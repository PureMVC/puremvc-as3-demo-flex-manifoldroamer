package org.puremvc.manifoldroamer.model.vo
{
	/**
	 *	<Project 
	 *		name="ActionScript 2 - Standard Version" 
	 *		status="Production"
	 *		repo="PureMVC_AS2" 
	 *		tag="1.0"
	 *		version="1.0"
	 *		archive="AS2/PureMVC_AS2.zip" 
	 *		docs="AS2/apidocs/frameset.html"
	 *		srcview=""
	 *		pic=""
	 *		shot=""
	 *		forum="board=13.0"
	 * 		owner="Pedr Brown"
	 * 		owner_node="304">
	 *			<Description><![CDATA[<P>PureMVC is a lightweight framework for creating applications based upon the classic Model-View-Controller design meta-pattern. This is the specific implementation for the ActionScript 2 language. See the Release Notes for this version for differences from the reference implementation.</P>]]></Description>						
	 *			<ReleaseNotes><![CDATA[<P>These are the Release Notes. These are the Release Notes. These are the Release Notes. These are the Release Notes. These are the Release Notes. These are the Release Notes. These are the Release Notes. These are the Release Notes. These are the Release Notes. </P>]]></Description>						
	 *			<Installation><![CDATA[<P>These are the Installation Instructions. These are the Installation Instructions. These are the Installation Instructions. These are the Installation Instructions. These are the Installation Instructions. These are the Installation Instructions. These are the Installation Instructions. </P>]]></Installation>												
	 *	</Framework>
	 */	
	
	[Bindable] public class ProjectVO extends NodeDataVO
	{
		public function ProjectVO( nodeData:XML )
		{
			super( nodeData );
		}


		public function get archive():String
		{
			return nodeData.@archive;
		} 
		
		public function set archive(url:String):void
		{
			nodeData.@archive = url;
		} 
		
		public function get docs():String
		{
			return nodeData.@docs;
		} 
		
		public function set docs(url:String):void
		{
			nodeData.@docs = url;
		} 

		public function get srcview():String
		{
			return nodeData.@srcview;
		} 
		
		public function set srcview(url:String):void
		{
			nodeData.@srcview = url;
		} 

		public function get forum():String
		{
			return nodeData.@forum;
		} 
		
		public function set forum(url:String):void
		{
			nodeData.@forum = url;
		} 
		
		public function get live():String
		{
			return nodeData.@live;
		} 
		
		public function set live(url:String):void
		{
			nodeData.@live = url;
		} 
		
		public function get repo():String
		{
			return nodeData.@repo;
		} 
		
		public function set repo(url:String):void
		{
			nodeData.@repo = url;
		} 
		
		public function get tag():String
		{
			return this.repo + "/tags/" + nodeData.@tag; 
		} 
		
		public function set tag(tag:String):void
		{
			nodeData.@tag = tag;
		} 
		
		public function get version():String
		{
			return nodeData.@version;
		} 
		
		public function set version(version:String):void
		{
			nodeData.@version = version;
		} 
		
		public function get status():String
		{
			return nodeData.@status;
		} 
		
		public function set status(status:String):void
		{
			nodeData.@status = status;
		} 
		
		public function get owner():String
		{
			return nodeData.@owner;
		} 
		
		public function set owner(name:String):void
		{
			nodeData.@owner = name;
		} 
		
		public function get owner_node():String
		{
			return nodeData.@owner_node;
		} 
		
		public function set owner_node(node:String):void
		{
			nodeData.@owner_node = node;
		} 
		
		public function get description():String
		{
			return nodeData..Description[0] as XML;
		} 
		
		public function set description(desc:String):void
		{
			nodeData..Description[0] = desc;
		} 
		
		public function get release_notes():String
		{
			return nodeData..ReleaseNotes[0] as XML;
		} 
		
		public function set release_notes(notes:String):void
		{
			nodeData..ReleaseNotes[0] = notes;
		} 
		
		public function get installation():String
		{
			return nodeData..Installation[0] as XML;
		} 
		
		public function set installation(notes:String):void
		{
			nodeData..Installation[0] = notes;
		} 
		
		public function get pic():String
		{
			return nodeData.@pic;
		} 
		
		public function set pic(url:String):void
		{
			nodeData.@pic = url;
		} 

		public function get shot():String
		{
			return nodeData.@shot;
		} 
		
		public function set shot(url:String):void
		{
			nodeData.@shot = url;
		} 

	}
}