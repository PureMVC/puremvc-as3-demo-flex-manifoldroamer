package org.puremvc.manifoldroamer.view
{
	import mx.managers.SystemManager;
	import flash.events.*;
	import flash.utils.*
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.manifoldroamer.ApplicationFacade;

	public class ApplicationMediator extends Mediator implements IMediator
	{
		
		public static const NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator( viewComponent:ManifoldRoamer )
		{
			super( NAME, viewComponent );
		}
		
		override public function onRegister():void
		{
			app.systemManager.stage.addEventListener( Event.RESIZE, onResize );
			app.addEventListener(ApplicationFacade.RESET, handleReset);
		}

		private function onResize( event:Event = null ):void
		{				
			if (resizeCount == 0) {
				var resizeTimer:Timer = new Timer(500, 1);
				resizeTimer.addEventListener(TimerEvent.TIMER, onResizeTimerElapsed);
				resizeTimer.start();
			} else {
				resizeCount++;
			}						
		}
	
		private function onResizeTimerElapsed(event:Event):void
		{
			if (resizeCount == 0) {
				sendNotification( ApplicationFacade.REFRESH );
			} else {
				resizeCount=0;
				var resizeTimer:Timer = new Timer(500, 1);
				resizeTimer.addEventListener(TimerEvent.TIMER, onResizeTimerElapsed);
				resizeTimer.start();
			}
		}
		
		public function handleReset(event:Event):void
		{
			sendNotification( ApplicationFacade.REFRESH );
		}
		
		protected function get app():ManifoldRoamer
		{
			return viewComponent as ManifoldRoamer;
		}
		
		private var resizeCount:int = 0;	
	}
}