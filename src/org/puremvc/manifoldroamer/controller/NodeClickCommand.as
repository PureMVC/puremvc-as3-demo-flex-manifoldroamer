package org.puremvc.manifoldroamer.controller
{
	import com.adobe.flex.extras.controls.springgraph.Item;

	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	import org.puremvc.manifoldroamer.view.components.Roamer;
	import org.puremvc.manifoldroamer.ApplicationFacade;
	import org.puremvc.manifoldroamer.model.UPSProxy;

	public class NodeClickCommand extends SimpleCommand implements ICommand
	{
        /**
         * Handle a node click
         */
        override public function execute( note:INotification ) : void    
        {
			// Get the id of the current item in the roamer
			var roamer:Roamer = note.getBody() as Roamer;
			var item:Item = roamer.currentItem as Item;
			var id:Number = Number(item.data.@id);

			// get the UPS proxy
			var upsProxy:UPSProxy = facade.retrieveProxy(UPSProxy.NAME) as UPSProxy;
			
			// get the corresponding UPS node to what was clicked on in the graph
			var node:XML = upsProxy.getNode( String( id ) );
			
			// If node is not populated, fetch it otherwise the node is selected
			if ( upsProxy.isPopulated( node ) ) 
			{
				sendNotification(ApplicationFacade.NODE_SELECTED, roamer);
			} else {
				upsProxy.fetchNode( node );
			}	
        }
		
	}
}