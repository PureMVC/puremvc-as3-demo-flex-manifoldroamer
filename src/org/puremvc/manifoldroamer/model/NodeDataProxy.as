package org.puremvc.manifoldroamer.model
{
	import org.puremvc.as3.patterns.proxy.Proxy;
	import org.puremvc.manifoldroamer.model.vo.ContributorVO;
	import org.puremvc.manifoldroamer.model.vo.DocumentVO;
	import org.puremvc.manifoldroamer.model.vo.NodeDataVO;
	import org.puremvc.manifoldroamer.model.vo.PresentationVO;
	import org.puremvc.manifoldroamer.model.vo.ProjectVO;
	import org.puremvc.manifoldroamer.model.vo.ShowcaseVO;
	import org.puremvc.manifoldroamer.model.vo.SiteVO;

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
					
				case NodeDataVO.DOCUMENT: // Populate DocumentVO
					var dvo:DocumentVO = new DocumentVO( nodeData );
					dvo.pic = prepend( configProxy.document.@pic_pre, dvo.pic );
					dvo.doc_url = prepend( configProxy.document.@doc_pre, dvo.doc_url );
					vo = dvo;
					break;

				case NodeDataVO.PRESENTATION: // Populate PresentationVO
					var pvo:PresentationVO = new PresentationVO( nodeData );
					pvo.pic = prepend( configProxy.presentation.@pic_pre, pvo.pic );
					vo = pvo;
					break;

				case NodeDataVO.PROJECT: // Populate ProjectVO
					var prvo:ProjectVO = new ProjectVO( nodeData );
					prvo.archive	= prepend( configProxy.project.@archive_pre, prvo.archive );
					prvo.docs 		= prepend( configProxy.project.@docs_pre, prvo.docs );
					prvo.forum 		= prepend( configProxy.project.@forum_pre, prvo.forum );
					prvo.live 		= prepend( configProxy.project.@live_pre, prvo.live );
					prvo.pic 		= prepend( configProxy.project.@pic_pre, prvo.pic );
					prvo.shot		= prepend( configProxy.project.@shot_pre, prvo.shot );
					prvo.html		= prepend( configProxy.project.@html_pre, prvo.repo ); // http://trac.puremvc.org/... repo is set in the XML node,
					prvo.repo 		= prepend( configProxy.project.@repo_pre, prvo.repo ); // http://svn.puremvc.org/...  but we also derive html url (and must to so first)
					prvo.srcview 	= prepend( configProxy.project.@srcview_pre, prvo.srcview );
					vo = prvo;
					break;

				case NodeDataVO.SHOWCASE: // Populate ShowcaseVO
					var svo:ShowcaseVO = new ShowcaseVO( nodeData );
					svo.pic = prepend( configProxy.showcase.@pic_pre, svo.pic );
					vo = svo;
					break;

				case NodeDataVO.SITE: // Populate SiteVO
					var stvo:SiteVO = new SiteVO( nodeData );
					stvo.pic = prepend( configProxy.site.@pic_pre, stvo.pic );
					vo = stvo;
					break;

			}

			return vo;
		}
		
		private function prepend( pre:String, url:String ):String
		{
			return ( isAbsolute(url) || url == '' )? url : pre + url;
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