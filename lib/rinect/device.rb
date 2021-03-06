module Rinect
  module Device
    attr_accessor :set
    attr_reader   :connect, :get
    
    DEVICES = {
      'Rinect::LED' => 0x02b0,
      'Rinect::Motor' => 0x02b0
    }
    
    def initialize
      @device ||= USB.devices.select {|d| d.idVendor == 0x045e && d.idProduct == DEVICES[self.class.to_s] }.first
      
      @handle = nil
      @state = :off
    end
    
    def inspect
      @device.inspect
    end
    
    def connect
      raise IOError, "Kinect not found/not connected." if @device.nil?

      @handle ||= @device.usb_open        
      self
    end
  end
end
