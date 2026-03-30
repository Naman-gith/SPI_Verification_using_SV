module spi_assertions(spi_if vif);

    property cs_low_during_transfer;
        @(posedge vif.clk)
        $fell(vif.cs) |-> ##[1:$] $rose(vif.cs);
    endproperty

    property sclk_active_when_cs_low;
        @(posedge vif.clk)
        (vif.cs == 0) |-> $changed(vif.sclk);
    endproperty

    property mosi_stable_on_sampling;
        @(posedge vif.clk)
        $rose(vif.sclk) |-> $stable(vif.mosi);
    endproperty

    property no_sclk_when_cs_high;
        @(posedge vif.clk)
        (vif.cs == 1) |-> $stable(vif.sclk);
    endproperty

    assert property(cs_low_during_transfer);
    assert property(sclk_active_when_cs_low);
    assert property(mosi_stable_on_sampling);
    assert property(no_sclk_when_cs_high);

endmodule
