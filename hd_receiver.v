module HD_RECEIVER #(parameter DATA_WIDTH = 32) (
    input                       clk         ,
    input                       rst         ,
    input      [DATA_WIDTH-1:0] data_src    ,
    input                       ready       ,
    input                       valid       ,
    output reg                  valid_output,
    output reg                  ready_output,
    output reg [DATA_WIDTH-1:0] data_dest
);
    reg [DATA_WIDTH-1:0] pipe_backup      ;
    reg                  pipe_backup_valid;
    always @(posedge clk) begin
        if(rst)begin
            pipe_backup <= 0;
        end
        else begin
            pipe_backup <= (ready_output && ~ready) ? data_src : pipe_backup;
        end
    end
    always @(posedge clk) begin
        if(rst)begin
            pipe_backup_valid <= 0;
        end
        else begin
            pipe_backup_valid <= ~ready && (ready_output ? valid : pipe_backup_valid);
        end
    end
    always @(*) begin
        data_dest = (pipe_backup_valid ? pipe_backup : data_src) ;
    end
    always @(*) begin
        valid_output = valid || pipe_backup_valid;
    end
    always @(*) begin
        ready_output = ~pipe_backup_valid;
    end
endmodule