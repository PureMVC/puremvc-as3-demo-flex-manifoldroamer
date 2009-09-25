package org.puremvc.manifoldroamer.model
{
	import org.puremvc.as3.patterns.proxy.*;
	import mx.collections.XMLListCollection;

	public class GraphProxy extends Proxy
	{
		public static const NAME:String = "GraphProxy";
		public static const GRAPH_CHANGED:String = "graphChanged";
		
		public function GraphProxy(  )
		{
			super( NAME, <graph><nodes/><edges/></graph> );
			
		}
		
		override public function onRegister():void
		{
			// Proxy collaborators			
			configProxy = facade.retrieveProxy( ConfigProxy.NAME ) as ConfigProxy;
			
		}
		
		public function addNode( node:XML, parent:XML=null ):void
		{
			
			// work with a copy 
			var graphNode:XML = node.copy();
			
			// process thumbnail URL
			var thumbURL:String = configProxy.getThumbURL( node.@thumb.toString() );
			graphNode.@thumb = thumbURL;

			// TBD - process picture URL
			
			// remove the Nodes node since the graph is not hierarchical
			delete graphNode.NodeMap.Nodes;

			// Remove the placeholder node from the graph
			delete graph..Node.(@id == graphNode.@id)[0];

			// add the populated node
			graph.nodes.appendChild(graphNode);
			
			// link it to it's parent if defined
			if (parent) graph.edges.appendChild(<Edge fromID={parent.@id} toID={graphNode.@id}/>);
		}		

		public function traverseNode( node:XML ):void
		{

			// add child Nodes to the graph
			for each ( var child:XML in node.NodeMap.Nodes..Node )
			{
				addNode( child, node );
			}
		}
		
		public function get graph():XML
		{
			return data as XML;
		}

		protected var configProxy:ConfigProxy;
	}
}