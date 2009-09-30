package org.puremvc.manifoldroamer.model.vo
{
	/**
	 * Expose a <code>Showcase</code> node as a value object. 
	 *
	 *		<Site 
	 *			name="Futurescale, Inc." 
	 *			site_url="http://futurescale.com/"
	 *			pic="PureMVC-Site-Futurescale.png">
	 *          <![CDATA[
	 *             <P>Futurescale offers architectural guidance 
	 *             and development expertise to aid in the implementation 
	 *             of Rich Internet Applications, specifically on the 
	 *             ActionScript-based Flex, Flash, AIR platforms.</P>
     *          ]]>							
	 *		</Site>
	 */
	[Bindable] public class SiteVO extends NodeDataVO
	{
		public function SiteVO( nodeData:XML )
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