package org.puremvc.manifoldroamer.model.vo
{
	[Bindable]
	public class NodeDataVO
	{
		public static const BLANK:String 		= "Blank";
		public static const DOCUMENT:String 	= "Document";
		public static const FRAMEWORK:String 	= "Framework";
		public static const DEMO:String 		= "Demo";
		public static const UTILITY:String 		= "Utility";
		public static const SHOWCASE:String 	= "Showcase";
		public static const CONTRIBUTOR:String 	= "Contributor";

		public function NodeDataVO( nodeData:XML=null )
		{
			this.nodeData = (nodeData != null)?nodeData:<Blank/>;
		}
		
		public function get type():String
		{
			return nodeData.localName();
		} 
		
		public var nodeData:XML;

		public static function getInstance( nodeData:XML ):NodeDataVO
		{
			var element:String = nodeData.localName();
			var vo:NodeDataVO;

			switch ( element ) {
				case NodeDataVO.CONTRIBUTOR:
					return new ContributorVO( nodeData );

				case NodeDataVO.DEMO:
					return new DemoVO( nodeData );

				case NodeDataVO.DOCUMENT:
					return new DocumentVO( nodeData );

				case NodeDataVO.FRAMEWORK:
					return new FrameworkVO( nodeData );

				case NodeDataVO.SHOWCASE:
					return new ShowcaseVO( nodeData );

				case NodeDataVO.UTILITY:
					return new UtilityVO( nodeData );

				default:
					return new NodeDataVO( );
			}

			return vo;
		}
	}
}