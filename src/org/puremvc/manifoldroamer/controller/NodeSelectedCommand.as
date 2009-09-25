package org.puremvc.manifoldroamer.controller
{
	import com.adobe.flex.extras.controls.springgraph.Item;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.manifoldroamer.ApplicationFacade;
	import org.puremvc.manifoldroamer.view.components.Roamer;

	public class NodeSelectedCommand extends SimpleCommand implements ICommand
	{
        /**
         * Handle a node click
         */
        override public function execute( note:INotification ) : void    
        {
			// the roamer and its root node
			var roamer:Roamer = note.getBody() as Roamer;
			var root:Item = roamer.getGraph().find('1');

			// the item and its id
			var item:Item = roamer.currentItem as Item;
			var id:Number = Number(item.data.@id);

			sendNotification(ApplicationFacade.HIDE_CONTENT);
			
			// Handle history 
			if (item == root) // reset history at the root
			{
				sendNotification(ApplicationFacade.RESET);
			} else { 
				sendNotification(ApplicationFacade.SHOW_HISTORY);
			}

        }
		
	}
}