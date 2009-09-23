package org.puremvc.manifoldroamer.view
{

	import flash.events.Event;
	import mx.core.Application;
	import flash.events.MouseEvent;

	import com.adobe.flex.extras.controls.springgraph.SpringGraph;
	import com.adobe.flex.extras.controls.springgraph.Item;
	import com.adobe.flex.extras.controls.springgraph.Graph;

	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	import org.puremvc.manifoldroamer.view.components.Roamer;
	import org.puremvc.manifoldroamer.view.components.Node;
	import org.puremvc.manifoldroamer.ApplicationFacade;
	import org.puremvc.manifoldroamer.model.UPSProxy;
	import org.puremvc.manifoldroamer.model.GraphProxy;
	
	public class RoamerMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "RoamerMediator";
		
		public function RoamerMediator( viewComponent:Roamer )
		{
			super( NAME, viewComponent );
			graphProxy = facade.retrieveProxy(GraphProxy.NAME) as GraphProxy;
			roamer.addEventListener(Node.SELECT, handleNodeSelect);
			roamer.addEventListener(Node.EXPAND, handleNodeExpand);
			roamer.addEventListener(MouseEvent.MOUSE_WHEEL, handleMouseWheel);
		}

		override public function listNotificationInterests():Array
		{
			return [ 
					 ApplicationFacade.RESET,
					 ApplicationFacade.SHOW_HISTORY,
					 ApplicationFacade.SCALE_GRAPH, 
					 GraphProxy.GRAPH_CHANGED
				   ];
		}

		override public function handleNotification(note:INotification):void
		{
			switch (note.getName()) 
			{
				case ApplicationFacade.RESET:
					roamer.dataProvider = roamer.dataProvider;
					roamer.repulsionFactor=1;
					roamer.autoFit=true;
					roamer.showHistory = false;
					roamer.refresh();
					break;
				
				case ApplicationFacade.SHOW_HISTORY:
					roamer.autoFit=true;
					roamer.showHistory = true;
					break;

				case ApplicationFacade.SCALE_GRAPH:
					roamer.autoFit=false;
					var delta:Number = (note.getBody() as Number)*.1;
					var targetScale:Number = roamer.repulsionFactor + (delta * .15);
					if (targetScale<=.1) targetScale = .1;
					if (targetScale>=3) targetScale = 3;
					roamer.repulsionFactor = targetScale;
					break;

				case GraphProxy.GRAPH_CHANGED:
					var id:String = note.getBody() as String;
					if (roamer.showHistory) { // backup history, set dataProvider, restore history
						var history:Array = roamer.getHistory();
						roamer.dataProvider = graphProxy.graph;
						roamer.resetHistory();
						roamer.showHistory = true;
						for (var i:int=0; i<history.length; i++)
						{
							roamer.setCurrentItemByID( String(Item(history[i]).data.@id) );
						}
					} else { // set dataProvider 
						roamer.dataProvider = graphProxy.graph;
					}
					roamer.setCurrentItemByID( id );
					sendNotification( ApplicationFacade.NODE_SELECTED, roamer );
					break;
			}
		}
		
		protected function handleNodeSelect(event:Event):void
		{
			sendNotification(ApplicationFacade.NODE_CLICK, roamer);			
		} 
		
		protected function handleNodeExpand(event:Event):void
		{
			sendNotification(ApplicationFacade.SHOW_CONTENT, Item(event.target.data).data);			
		} 
		
		protected function handleMouseWheel(event:MouseEvent):void
		{
			sendNotification(ApplicationFacade.SCALE_GRAPH, event.delta);
		}
		
		protected function get roamer():Roamer
		{
			return viewComponent as Roamer;
		}
		
		protected var graphProxy:GraphProxy;
	}
}