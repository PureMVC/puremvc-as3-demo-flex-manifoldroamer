package org.puremvc.manifoldroamer.controller
{
	import com.adobe.flex.extras.controls.springgraph.Item;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.manifoldroamer.ApplicationFacade;
	import org.puremvc.manifoldroamer.model.vo.NodeDataVO;

	public class NodeExpandedCommand extends SimpleCommand implements ICommand
	{
        /**
         * Handle a expanding a node to view its content
         */
        override public function execute( note:INotification ) : void    
        {
			// Extract the content element from the node's NodeMap
			var node:XML = note.getBody() as XML;
			var contents:XMLList = node.NodeMap.children();
			var content:XML = contents[0];
			var nodeData:NodeDataVO = NodeDataVO.getInstance( content );
			
			// If valid content was found, send it
			if (nodeData.type != NodeDataVO.BLANK) { 
				sendNotification(ApplicationFacade.SHOW_CONTENT, nodeData );
			}
        }
		
	}
}