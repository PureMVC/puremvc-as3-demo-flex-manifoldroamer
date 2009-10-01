package org.puremvc.manifoldroamer.model.vo
{
	[Bindable]
	public class NodeDataVO
	{
		public static const BLANK:String 		= "Blank";
		public static const DOCUMENT:String 	= "Document";
		public static const PROJECT:String 		= "Project";
		public static const SHOWCASE:String 	= "Showcase";
		public static const CONTRIBUTOR:String 	= "Contributor";
		public static const PRESENTATION:String	= "Presentation";
		public static const SITE:String			= "Site";

		public function NodeDataVO( nodeData:XML=null )
		{
			this.nodeData = (nodeData != null)?nodeData:<Blank/>;
		}
		
		public function get type():String
		{
			return nodeData.localName();
		} 
		
		public function get name():String
		{
			return nodeData.@name;
		} 
		
		
		
		public var nodeData:XML;

	}
}