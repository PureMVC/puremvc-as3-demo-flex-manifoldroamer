package org.puremvc.manifoldroamer.model.vo
{
	/**
	 * Expose a <code>Document</code> node as a value object. 
	 *
	 *		<Document 
	 *		    name="PureMVC Best Practices and Implementation Idioms (Chinese Translation)"
	 *          author="Cliff Hall (Translated by  Zhang Ze Yuan and Zhong Xiao Chuan)"
	 *		    doc_url="http://puremvc.org/component/option,com_wrapper/Itemid,183/"
	 *		    pic="http://puremvc.org/images/stories/flags/puremvc-chinese.png"><![CDATA[
	 *		    	<P>It is my pleasure to tender a big Toa chie / M goi to Zhang Ze Yuan and Zhong Xiao Chuan, 
	 *		    	who have worked together to complete the translation of the PureMVC Implementation Idiom
	 *		    	and Best Practices document into Chinese. As with the original, examples are in ActionScript 3 
	 *		    	for Adobe Flex, Flash and AIR.</P>
	 *		    	<P>Thanks again to Zhang and Zhong for your your efforts,<BR/>
	 *		    	-=Cliff&gt;</P>
	 *		    ]]></Document>
	 */	
	[Bindable] public class DocumentVO extends NodeDataVO
	{
		public function DocumentVO( nodeData:XML )
		{
			super( nodeData );
		}

		public function get doc_url():String
		{
			return nodeData.@doc_url;
		} 
		
		public function set doc_url(url:String):void
		{
			nodeData.@doc_url = url;
		} 
		
		public function get author():String
		{
			return nodeData.@author;
		} 
		
		public function set author(name:String):void
		{
			nodeData.@author = name;
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