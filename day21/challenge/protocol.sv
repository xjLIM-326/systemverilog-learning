module protocol (
    input  logic clk,
    input  logic reset_n,

    input  logic req,

    output logic grant,
    output logic busy,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        GRANT,
        ACTIVE
    } state_t;

    state_t state;

    logic req_pending;
    logic [1:0] busy_count;


    // ------------------------------------------------
    // State machine
    // ------------------------------------------------

    always_ff @(posedge clk) begin

        if (!reset_n) begin

            state       <= IDLE;
            req_pending <= 1'b0;
            busy_count  <= 2'd0;

        end
        else begin

            case (state)

                // ------------------------------------
                // IDLE
                // ------------------------------------

                IDLE: begin

                    req_pending <= 1'b0;
                    busy_count  <= 2'd0;

                    if (req) begin
                        req_pending <= 1'b1;
                        state       <= GRANT;
                    end

                end


                // ------------------------------------
                // GRANT
                //
                // grant occurs 1 cycle after req
                // ------------------------------------

                GRANT: begin

                    req_pending <= 1'b0;
                    busy_count  <= 2'd0;

                    state <= ACTIVE;

                end


                // ------------------------------------
                // ACTIVE
                //
                // busy remains high for 3 cycles
                // ------------------------------------

                ACTIVE: begin

                    if (busy_count == 2'd2) begin

                        busy_count <= 2'd0;
                        state      <= IDLE;

                    end
                    else begin

                        busy_count <= busy_count + 1'b1;

                    end

                end

            endcase

        end

    end


    // ------------------------------------------------
    // Output logic
    // ------------------------------------------------

    always_comb begin

        grant = 1'b0;
        busy  = 1'b0;
        done  = 1'b0;

        case (state)

            IDLE: begin
                // No active transaction
            end


            GRANT: begin
                grant = 1'b1;
                busy  = 1'b1;
            end


            ACTIVE: begin

                busy = 1'b1;

                if (busy_count == 2'd2)
                    done = 1'b1;

            end

        endcase

    end

endmodule