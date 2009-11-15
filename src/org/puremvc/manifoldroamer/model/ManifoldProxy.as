package org.puremvc.manifoldroamer.model
{
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.puremvc.as3.patterns.proxy.*;

	public class ManifoldProxy extends Proxy
	{
		public static const NAME:String = "ManifoldProxy";
		
		public static const NODE_RETRIEVED:String = NAME+"/node/received";
		public static const STUB_NODE_FILLED:String = NAME+"stub/node/filled";
		
		public function ManifoldProxy( data:Object=null )
		{
			super(NAME, new XML(<Manifold></Manifold>));
			
		}
		
		override public function onRegister():void
		{
			// Proxy collaborators
			configProxy = facade.retrieveProxy( ConfigProxy.NAME ) as ConfigProxy;
			
			// Service listeners
			service.addEventListener(ResultEvent.RESULT, result);
			service.addEventListener(FaultEvent.FAULT, fault);
			service.resultFormat="e4x";
			
		}
		
		public function initializeRoot():void
		{
			// Set placeholder and fetch root node			
			manifold.appendChild( configProxy.root );
			fetchNode( getNode( configProxy.rootID ) );
		}
		
		/**
		 * Fetch the given node from the remote service.
		 * <P>
		 * A minimally populated stub node is sent from 
		 * the server for nodes at a certain depth on 
		 * each call to prevent recursively sending the
		 * entire tree at once.</P>
		 * <P>
		 * When the user navigates to one of these stubs, 
		 * we fetch the populated node from the remote 
		 * service. and replace the all instances of the
		 * stub node with the populated node.</P>
		 * 
		 * @param the stub node from the local data structure
		 */
		public function fetchNode( node:XML ):void
		{
			service.url = configProxy.getRESTServiceURL( node.@id );
			var token:AsyncToken = service.send();
			token.type = node.@type;
		}

		/**
		 * Get the first node of the list that match the given id
		 * <P>
		 * Since the same node can appear under different
		 * nodes, this is a list and not a single XML 
		 * object.</P>
		 * 
		 * @param id the id value of the node to find
		 */
		public function getNode( id:String ):XML
		{
			return manifold..Node.(@id == id)[0];	
		}
		
		/**
		 * Set node matching the given ID
		 * <P>
		 * Since the same node can appear under different
		 * nodes, this is a list and not a single XML 
		 * object.</P>
		 * 
		 * @param id the id value of the node to find
		 */
		public function setNode( node:XML ):void
		{
			manifold..Node.(@id == node.@id)[0] = node;
		}
		
		/**
		 * Handle returned node.
		 * <P>
		 * we have received a node. we now 
		 * replace the stubbed node with the 
		 * received node of the same id.
		 * if the node appears in multiple places 
		 * throughout the graph, it is replaced 
		 * everywhere. Thus if the same node 
		 * were under 3 different nodes, 
		 * all three nodes would be replaced with
		 * this one, which should be populated
		 * </P>
		 */
		public function result( event:ResultEvent ):void
		{
			var node:XML = event.result as XML;
		
			// replace the placeholder node in the Manifold tree
			setNode( event.result as XML );
			
			// notify that the node was retrieved
			sendNotification( NODE_RETRIEVED, node );

			// If the node was type stub, also send the notification that has been filled
			if ( event.token.type == "stub") sendNotification( STUB_NODE_FILLED, node );

		}
			
		/**
		 * Does this node have a NodeMap?
		 */
		public function isPopulated( node:XML ):Boolean
		{
			return ( XMLList(node..NodeMap).length() > 0 );
		}
				
		/**
		 * How many children does this node have?
		 */
		public function childNodeCount( node:XML ):Number
		{
			return ( isPopulated(node) )?XMLList(node..NodeMap).length():0;
		}
				
		/**
		 * How many siblings does this node have?
		 */
		public function siblingNodeCount( node:XML ):Number
		{
			var sibs:XMLList = XML(node.parent()).children();
			return sibs.length();
		}
				
		public function fault( event:FaultEvent ):void
		{
			
		}

		public function get manifold():XML
		{
			return data as XML;
		}
		
		protected var service:HTTPService = new HTTPService();
		protected var configProxy:ConfigProxy;
	}
}