class spi_driver;
    virtual spi_if vif;
    mailbox #(spi_transaction) gen2drv;

    function new(virtual spi_if vif, mailbox #(spi_transaction) gen2drv);
        this.vif = vif;
        this.gen2drv = gen2drv;
    endfunction

    task run();
        spi_transaction tr;
        forever
        begin
            gen2drv.get(tr);
            drive(tr);
        end
    endtask

    task drive(spi_transaction tr);
        vif.cs <= 0;
        for (int i = 7; i >= 0; i--)
        begin
            vif.mosi <= tr.data[i];
            @(posedge vif.sclk);
        end
        vif.cs <= 1;
    endtask
endclass
