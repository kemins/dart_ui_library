import "dart:html";

abstract class OverlayManager {
  
  Element get POPUP_OVERLAY => null;
  
  factory OverlayManager.instance() {
    
    if (_instance == null) {
      _instance = new OverlayManagerImpl(); 
    }
    return _instance;
  }
  
  void init(OverlayConfig config);
  
  static OverlayManager _instance;
}

class OverlayManagerImpl implements OverlayManager {
  OverlayManagerImpl() {
  }
  
  @override
  Element get POPUP_OVERLAY => config.POPUP_OVERLAY;
  
  @override
  void init(OverlayConfig config) {
    this.config = config;
  }
  
  OverlayConfig config;
}

class OverlayConfig {
  OverlayConfig(this.POPUP_OVERLAY) {
    
  }
  
  Element POPUP_OVERLAY;
}