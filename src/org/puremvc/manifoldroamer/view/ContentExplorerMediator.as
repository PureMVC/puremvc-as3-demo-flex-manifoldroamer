package org.puremvc.manifoldroamer.view
{
	import flash.events.*;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.manifoldroamer.ApplicationFacade;
	import org.puremvc.manifoldroamer.model.vo.NodeDataVO;
	import org.puremvc.manifoldroamer.view.components.ContentExplorer;

	public class ContentExplorerMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "ContentExplorerMediator";
		
		public function ContentExplorerMediator( viewComponent:ContentExplorer )
		{
			super( NAME, viewComponent );
		}
		
		override public function onRegister():void
		{
			explorer.addEventListener(ApplicationFacade.RESET, handleReset );
			explorer.addEventListener(ApplicationFacade.RESET, handleHideContent );			
		}

		override public function listNotificationInterests():Array
		{
			return [ApplicationFacade.SHOW_CONTENT,
					ApplicationFacade.HIDE_CONTENT];
		}

		override public function handleNotification(note:INotification):void
		{
			switch (note.getName()) 
			{
				case ApplicationFacade.SHOW_CONTENT:
					explorer.showContent = true;
					explorer.nodeData = note.getBody() as NodeDataVO;
					break;
					
				case ApplicationFacade.HIDE_CONTENT:
					explorer.showContent = false;
					break;
			}
		}
		
		public function handleReset(event:Event):void
		{
			sendNotification( ApplicationFacade.RESET );
			sendNotification( ApplicationFacade.HIDE_CONTENT );
		}
		
		public function handleHideContent(event:Event):void
		{
			sendNotification( ApplicationFacade.HIDE_CONTENT );
		}
		
		protected function get explorer():ContentExplorer
		{
			return viewComponent as ContentExplorer;
		}
		
	}
}