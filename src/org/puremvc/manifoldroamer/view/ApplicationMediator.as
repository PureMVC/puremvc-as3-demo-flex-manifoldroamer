package org.puremvc.manifoldroamer.view
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import flash.events.Event;
	import org.puremvc.manifoldroamer.ApplicationFacade;

	public class ApplicationMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator( viewComponent:UPSRoamer )
		{
			super( NAME, viewComponent );
			app.addEventListener(ApplicationFacade.RESET, handleReset);
		}

		override public function listNotificationInterests():Array
		{
			return [];
		}

		override public function handleNotification(note:INotification):void
		{
		}
		
		public function handleReset(event:Event):void
		{
			sendNotification( ApplicationFacade.RESET );
		}
		
		protected function get app():ManifoldRoamer
		{
			return viewComponent as UPSRoamer;
		}
		
	}
}