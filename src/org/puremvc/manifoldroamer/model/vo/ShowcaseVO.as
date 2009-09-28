package org.puremvc.manifoldroamer.model.vo
{
	/**
	 * Expose a <code>Showcase</code> node as a value object. 
	 *
	 *		<Showcase 
	 *			name="The World's Biggest Ad" 
	 *			site_url="http://www.theworldsbiggestad.com/"
	 *			author="TBWA Tequila - Singapore"
	 *			author_url="http://www.tbwa.com/"
	 *			pic="wba.jpg">
	 */
	[Bindable] public class ShowcaseVO extends NodeDataVO
	{
		
		public function ShowcaseVO( nodeData:XML )
		{
			super( nodeData );
		}
		
		public function get site_url():String
		{
			return nodeData.@site_url;
		} 
		
		public function set site_url(url:String):void
		{
			nodeData.@site_url = url;
		} 
		
		public function get author():String
		{
			return nodeData.@author;
		} 
		
		public function set author(name:String):void
		{
			nodeData.@author = name;
		} 
		
		public function get author_url():String
		{
			return nodeData.@author_url;
		} 
		
		public function set author_url(url:String):void
		{
			nodeData.@author_url = url;
		} 
		
		public function get pic():String
		{
			return nodeData.@pic;
		} 
		
		public function set pic(url:String):void
		{
			nodeData.@pic = url;
		} 
		
	}
}