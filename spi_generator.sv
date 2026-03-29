class spi_generator;
    mailbox #(spi_transaction) gen2drv;
    function new(mailbox #(spi_transaction) gen2drv);
        this.gen2drv = gen2drv;
    endfunction

    task run();
        spi_transaction tr;
        repeat (20)
        begin
            tr = new();
            assert(tr.randomize());
            gen2drv.put(tr);
        end
    endtask
endclass
