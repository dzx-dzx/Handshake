`include "hd.v"
module HD_tb;

// Parameters
localparam DATA_WIDTH = 16;

// Ports
reg                   clk       = 0;
reg                   rst       = 0;
reg                   ready     = 0;
reg                   valid     = 0;
reg  [DATA_WIDTH-1:0] data_src     ;
wire [DATA_WIDTH-1:0] data_dest    ;
wire ready_output;

HD #(
    .DATA_WIDTH(          
                DATA_WIDTH)  
) HD_dut (
    .clk      (clk      ),
    .rst      (rst      ),
    .ready    (ready    ),
    .valid    (valid    ),
    .data_src (data_src ),
    .data_dest(data_dest),
    .ready_output(ready_output)
);


always
    #5  clk = ! clk ;
always @(negedge clk) begin
    if(ready_output&&valid)data_src=data_src+1;
end

initial begin
    clk=0;
    $dumpfile("wave.vcd");
    $dumpvars(0, HD_tb);
    data_src=1;
    @(negedge clk) rst=1;
    @(negedge clk) rst=0;
    @(negedge clk) ;
    @(negedge clk) valid=1;
    @(negedge clk) ;
    @(negedge clk) ready=1;
    @(negedge clk) ready=0;
    @(negedge clk) ;
    @(negedge clk) ;
    @(negedge clk) ;
    @(negedge clk) valid=0;
    @(negedge clk) valid=1;
    @(negedge clk) ;
    @(negedge clk) ready=1;
    @(negedge clk) ;
    @(negedge clk) ;
    @(negedge clk) ;
    @(negedge clk) ;
    @(negedge clk) ready=0;
    @(negedge clk) ;
    @(negedge clk) ;
    @(negedge clk) valid=0;
    @(negedge clk) ;
    @(negedge clk) ;
    @(negedge clk) ready=1;
    @(negedge clk) ;
    @(negedge clk) valid=1;
    @(negedge clk) ;
    @(negedge clk) valid=0;
    @(negedge clk) ready=0;
    #50 $finish;
end


endmodule
