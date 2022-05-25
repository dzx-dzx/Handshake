module HD_RECEIVER #(parameter DATA_WIDTH = 32) (
    input                       clk              ,
    input                       rst              ,
    input                       ready            ,
    input      [DATA_WIDTH-1:0] pipe_data        ,
    input                       pipe_valid       ,
    output reg                  ready_output     ,
    output reg [DATA_WIDTH-1:0] data_dest        ,
    output reg [DATA_WIDTH-1:0] pipe_backup      ,
    output reg                  pipe_backup_valid
);

    always @(posedge clk) begin
        if(rst)begin
            pipe_backup <= 0;
        end
        else begin
            pipe_backup <= (ready_output && ~ready) ? pipe_data : pipe_backup;
        end
    end
    always @(posedge clk) begin
        if(rst)begin
            pipe_backup_valid <= 0;
        end
        else begin
            pipe_backup_valid <= ~ready && (ready_output ? pipe_valid : pipe_backup_valid);
        end
    end
    always @(*) begin
        ready_output = ~pipe_backup_valid;
    end
    always @(*) begin
        data_dest = (pipe_backup_valid ? pipe_backup : pipe_data) ;
    end

endmodule