class spi_monitor;
    virtual spi_if vif;
    mailbox #(spi_transaction) mon2scb;

    function new(virtual spi_if vif, mailbox #(spi_transaction) mon2scb);
        this.vif = vif;
        this.mon2scb = mon2scb;
    endfunction

    task run();
        spi_transaction tr;
        forever
        begin
            @(negedge vif.cs);
            tr = new();
            for (int i = 7; i >= 0; i--)
            begin
                @(posedge vif.sclk);
                tr.rx_data[i] = vif.miso;
            end
            mon2scb.put(tr);
        end
    endtask
endclass
