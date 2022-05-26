`include "hd_sender.v"
`include "hd_receiver.v"
module HD_COMPART #(parameter DATA_WIDTH = 32) (
    input                   clk         ,
    input                   rst         ,
    input                   ready       ,
    input                   valid       ,
    input  [DATA_WIDTH-1:0] data_src    ,
    output [DATA_WIDTH-1:0] data_dest   ,
    output                  ready_output,
    output                  valid_output
);
wire [DATA_WIDTH-1:0] pipe_data        ;
wire                  pipe_valid       ;
wire                  pipe_ready       ;

HD_SENDER #(.DATA_WIDTH(DATA_WIDTH)) hd_sender (
    .clk         (clk         ),
    .rst         (rst         ),
    .data_src    (pipe_data   ),
    .ready       (ready       ),
    .valid       (pipe_valid  ),
    .ready_output(pipe_ready  ),
    .valid_output(valid_output),
    .data_dest   (data_dest   )
);

HD_RECEIVER #(.DATA_WIDTH(DATA_WIDTH)) hd_receiver (
    .clk         (clk         ),
    .rst         (rst         ),
    .data_src    (data_src    ),
    .ready       (pipe_ready  ),
    .valid       (valid       ),
    .ready_output(ready_output),
    .valid_output(pipe_valid  ),
    .data_dest   (pipe_data   )
);

endmodule