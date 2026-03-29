class spi_env;
    spi_generator gen;
    spi_driver drv;
    spi_monitor mon;
    spi_scoreboard scb;

    mailbox #(spi_transaction) gen2drv;
    mailbox #(spi_transaction) mon2scb;

    function new(virtual spi_if vif);
        gen2drv = new();
        mon2scb = new();

        gen = new(gen2drv);
        drv = new(vif, gen2drv);
        mon = new(vif, mon2scb);
        scb = new(mon2scb);
    endfunction

    task run();
        fork
            gen.run();
            drv.run();
            mon.run();
            scb.run();
        join_none
    endtask
endclass
