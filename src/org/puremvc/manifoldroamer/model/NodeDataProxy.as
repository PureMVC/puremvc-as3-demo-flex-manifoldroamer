package org.puremvc.manifoldroamer.model
{
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.manifoldroamer.model.vo.ContributorVO;
	import org.puremvc.manifoldroamer.model.vo.DemoVO;
	import org.puremvc.manifoldroamer.model.vo.DocumentVO;
	import org.puremvc.manifoldroamer.model.vo.FrameworkVO;
	import org.puremvc.manifoldroamer.model.vo.NodeDataVO;
	import org.puremvc.manifoldroamer.model.vo.PresentationVO;
	import org.puremvc.manifoldroamer.model.vo.ShowcaseVO;
	import org.puremvc.manifoldroamer.model.vo.SiteVO;
	import org.puremvc.manifoldroamer.model.vo.UtilityVO;

	public class NodeDataProxy extends Proxy
	{
		public static const NAME:String = "NodeDataProxy";
		
		public function NodeDataProxy( configProxy:ConfigProxy )
		{
			super( NAME, configProxy );
		}
		
		public function getInstance( nodeData:XML ):NodeDataVO
		{
			var element:String = nodeData.localName();
			var vo:NodeDataVO = new NodeDataVO( );

			switch ( element ) {
				case NodeDataVO.CONTRIBUTOR:
					vo = ContributorVO( nodeData );
					break;
					
				case NodeDataVO.DEMO:
					vo = new DemoVO( nodeData );
					break;

				case NodeDataVO.DOCUMENT: // Populate DocumentVO
					var dvo:DocumentVO = new DocumentVO( nodeData );
					dvo.pic = prepend( configProxy.document.@pic_pre, dvo.pic );
					dvo.doc_url = prepend( configProxy.document.@doc_pre, dvo.doc_url );
					vo = dvo;
					break;

				case NodeDataVO.FRAMEWORK:
					vo = new FrameworkVO( nodeData );
					break;

				case NodeDataVO.SHOWCASE: // Populate ShowcaseVO
					var svo:ShowcaseVO = new ShowcaseVO( nodeData );
					svo.pic = prepend( configProxy.showcase.@pic_pre, svo.pic );
					vo = svo;
					break;
				case NodeDataVO.SITE:
					vo = new SiteVO( nodeData );
					break;

				case NodeDataVO.PRESENTATION:
					vo = new PresentationVO( nodeData );
					break;

				case NodeDataVO.UTILITY:
					vo = new UtilityVO( nodeData );
					break;

			}

			return vo;
		}
		
		private function prepend( pre:String, url:String ):String
		{
			return ( isAbsolute(url) )? url : pre + url;
		}
		private function isAbsolute(url:String):Boolean
		{
			return ( url.search("http") == 0);
		}
		
		private function get configProxy():ConfigProxy
		{
			return data as ConfigProxy;
		}
		
	}
}