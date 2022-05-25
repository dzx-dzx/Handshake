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
wire [DATA_WIDTH-1:0] pipe_backup      ;
wire                  pipe_valid       ;
wire                  pipe_backup_valid;
HD_SENDER #(.DATA_WIDTH(DATA_WIDTH)) hd_sender (
    .clk              (clk              ),
    .rst              (rst              ),
    .data_src         (data_src         ),
    .ready_output     (ready_output     ),
    .valid            (valid            ),
    .pipe_backup_valid(pipe_backup_valid),
    .valid_output     (valid_output     ),
    .pipe_valid       (pipe_valid       ),
    .pipe_data        (pipe_data        )
);

HD_RECEIVER #(.DATA_WIDTH(DATA_WIDTH)) hd_receiver (
    .clk              (clk              ),
    .rst              (rst              ),
    .ready            (ready            ),
    .pipe_data        (pipe_data        ),
    .pipe_valid       (pipe_valid       ),
    .ready_output     (ready_output     ),
    .data_dest        (data_dest        ),
    .pipe_backup      (pipe_backup      ),
    .pipe_backup_valid(pipe_backup_valid)
);

endmodule