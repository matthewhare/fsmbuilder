package mvcs.utils.autoupdate
{
	import air.update.events.DownloadErrorEvent;
	import air.update.events.StatusFileUpdateErrorEvent;
	import air.update.events.StatusFileUpdateEvent;
	import air.update.events.StatusUpdateErrorEvent;
	import air.update.events.StatusUpdateEvent;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.ProgressEvent;

	public class AutoUpdater
	{
		public function AutoUpdater()
		{
			checkUpdate();
		}
		
		import air.update.events.UpdateEvent;
		import mx.controls.Alert; 
		import flash.events.ErrorEvent; 
		import air.update.ApplicationUpdaterUI; /** * @var the object that that handles the update related actions */ 
		
		static public var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI(); 
		
		/** This function is triggered when the application finished to load; 
		 * Here we initialize <code>appUpdater</code> and set some properties 
		 **/ 
		
		private function checkUpdate():void 
		{ 

			// we set the URL for the update.xml file 
//			https://raw.github.com/matthewhare/fsmbuilder/master/updater/update.xml
			appUpdater.updateURL = "http://cloud.github.com/downloads/matthewhare/fsmbuilder/update.xml"; 
			//we set the event handlers for INITIALIZED nad ERROR 
			appUpdater.addEventListener(UpdateEvent.INITIALIZED, onUpdate);
			appUpdater.addEventListener(Event.DEACTIVATE, eventHandler);
			
			appUpdater.addEventListener(UpdateEvent.CHECK_FOR_UPDATE, eventHandler)
			appUpdater.addEventListener(UpdateEvent.BEFORE_INSTALL, eventHandler)
			appUpdater.addEventListener(UpdateEvent.DOWNLOAD_COMPLETE, eventHandler)
			appUpdater.addEventListener(UpdateEvent.DOWNLOAD_START, eventHandler)
				
			appUpdater.addEventListener(ProgressEvent.PROGRESS, eventHandler);
			appUpdater.addEventListener(StatusUpdateEvent.UPDATE_STATUS, eventHandler);
			appUpdater.addEventListener(StatusFileUpdateEvent.FILE_UPDATE_STATUS, eventHandler)

			// ERRORS
				
			appUpdater.addEventListener(StatusFileUpdateErrorEvent.FILE_UPDATE_ERROR, eventHandler)
			appUpdater.addEventListener(DownloadErrorEvent.DOWNLOAD_ERROR, eventHandler)
			appUpdater.addEventListener(ErrorEvent.ERROR, eventHandler); 
			appUpdater.addEventListener(StatusUpdateErrorEvent.UPDATE_ERROR, eventHandler)
			//we can hide the dialog asking for permission for checking for a new update;
			//if you want to see it just leave the default value (or set true).
			appUpdater.isCheckForUpdateVisible = false; 
			//if isFileUpdateVisible is set to true, File Update, File No Update, //
			// and File Error dialog boxes will be displayed appUpdater.isFileUpdateVisible = false; 
			//if isInstallUpdateVisible is set to true, the dialog box for installing the update is visible 
			appUpdater.isInstallUpdateVisible = false; 
			//we initialize the updater 
			appUpdater.initialize(); 
		}

		private function eventHandler(event:Event):void
		{
			trace("AutoUpdate::event type ["+event.type+"]");
			switch (event.type)
			{
				case UpdateEvent.CHECK_FOR_UPDATE:
					
					break;
				case StatusUpdateEvent.UPDATE_STATUS:
					versionString = appUpdater.currentVersion;
					break;
				case StatusFileUpdateErrorEvent.FILE_UPDATE_ERROR:
				case DownloadErrorEvent.DOWNLOAD_ERROR:
				case ErrorEvent.ERROR:
				case StatusUpdateErrorEvent.UPDATE_ERROR:
					versionString = appUpdater.currentVersion + "(error:"+event.type+")";
					break;
				case UpdateEvent.DOWNLOAD_START:
					versionString = "downloading updates.."
					break;
				case UpdateEvent.DOWNLOAD_COMPLETE:
					versionString = appUpdater.currentVersion;
					break;
			}
			
			
		} 
		
		/** 
		 * * Handler function triggered by the ApplicationUpdater.initialize; 
		 * * The updater was initialized and it is ready to take commands 
		 * * (such as <code>checkNow()</code> 
		 * * @param UpdateEvent 
		 * */ 
		private function onUpdate(event:UpdateEvent):void 
		{ 
			//start the process of checking for a new update and to install 
			versionString = "checking for updates..";
			appUpdater.checkNow(); 
		}
		
		/** 
		 * * Handler function for error events triggered by the ApplicationUpdater.initialize 
		 * * @param ErrorEvent 
		 * */ 
		private function onError(event:ErrorEvent):void 
		{ 
			AutoUpdater.versionString = "error : " + event.toString()
//			Alert.show(event.toString()); 
		} 
		
		public function checkNow():void
		{
			appUpdater.checkNow();
		}

		
		[Bindable]
		static public var versionString:String = "..";
	}
}