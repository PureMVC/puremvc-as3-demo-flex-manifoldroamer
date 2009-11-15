package org.puremvc.manifoldroamer.controller
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.manifoldroamer.model.GraphProxy;
	import org.puremvc.manifoldroamer.model.ManifoldProxy;

	public class UpdateGraphCommand extends SimpleCommand
	{
        /**
         * When a node is retrieved, update the graph
         */
        override public function execute( note:INotification ) : void    
        {
			// Get the retrieved node from the note body
			var node:XML = note.getBody() as XML;
			
			// Retrieve the GraphProxy
        	var graphProxy:GraphProxy = facade.retrieveProxy( GraphProxy.NAME ) as GraphProxy;

			// Add the node to the Graph
			graphProxy.addNode( node );
			
			// Add any nodes under this one to the graph as well
			graphProxy.traverseNode( node );
			
        }
	}
}