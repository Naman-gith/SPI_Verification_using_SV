module tb;

    logic clk;
    always #5 clk = ~clk;

    spi_if vif(clk);

    spi_env env;

    initial
    begin
        clk = 0;
        vif.rst = 1;
        #20;
        vif.rst = 0;

        env = new(vif);
        env.run();

        #2000;
        $finish;
    end

endmodule
