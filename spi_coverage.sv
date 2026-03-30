class spi_coverage;

    virtual spi_if vif;

    bit [7:0] data_sample;
    int mode;

    covergroup spi_cg @(posedge vif.sclk);

        option.per_instance = 1;

        data_cp : coverpoint data_sample {
            bins zero = {8'h00};
            bins ones = {8'hFF};
            bins alt1 = {8'hAA};
            bins alt2 = {8'h55};
            bins walking1[] = {8'h01,8'h02,8'h04,8'h08,8'h10,8'h20,8'h40,8'h80};
            bins others[] = {[1:254]};
        }

        mode_cp : coverpoint mode {
            bins mode0 = {0};
            bins mode1 = {1};
            bins mode2 = {2};
            bins mode3 = {3};
        }

        cross data_cp, mode_cp;

    endgroup

    function new(virtual spi_if vif);
        this.vif = vif;
        spi_cg = new();
    endfunction

    task sample(bit [7:0] data, int m);
        data_sample = data;
        mode = m;
        spi_cg.sample();
    endtask

endclass
