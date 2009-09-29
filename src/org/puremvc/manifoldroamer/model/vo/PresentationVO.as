package org.puremvc.manifoldroamer.model.vo
{
	/**
	 * Expose a <code>Presentation</code> node as a value object. 
	 *
	 *		<Presentation  
	 *		    name="PureMVC State Machine Utility Overview" 
	 * 			site_url="http://puremvc.tv/#P003/"
	 * 			speaker="Cliff Hall"
	 * 			speaker_url="http://futurescale.com"
	 * 			pic="http://puremvc.tv/assets/icon/statemachine/title.png"><![CDATA[
	 * 				<P>A platform and language neutral introduction to the PureMVC 
	 * 				   State Machine Utility delivered as a slideshow narrated 
	 *                 by Cliff Hall on PureMVC TV.</P>
	 *		    ]]></Presentation>
	 */	
	[Bindable]
	public class PresentationVO extends NodeDataVO
	{
		public function PresentationVO( nodeData:XML )
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
		
		public function get speaker():String
		{
			return nodeData.@speaker;
		} 
		
		public function set speaker(name:String):void
		{
			nodeData.@speaker = name;
		} 
		
		public function get speaker_url():String
		{
			return nodeData.@speaker_url;
		} 
		
		public function set speaker_url(url:String):void
		{
			nodeData.@speaker_url = url;
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