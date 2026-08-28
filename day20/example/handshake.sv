module handshake (
    input logic clk,
    input logic reset_n,

    input logic req,
    input logic ack
);

    // ------------------------------------------------
    // Sequence
    // ------------------------------------------------
    // Describes what should happen after the trigger.
    //
    // ##1 ack means:
    // ACK must be asserted one cycle later.
    // ------------------------------------------------

    sequence ack_next_cycle;
        ##1 ack;
    endsequence


    // ------------------------------------------------
    // Property
    // ------------------------------------------------
    // REQ is the trigger.
    //
    // If REQ happens,
    // the sequence "ACK one cycle later"
    // must be satisfied.
    // ------------------------------------------------

    property req_ack_property;
        @(posedge clk)
        disable iff (!reset_n)
        req |-> ack_next_cycle;
    endproperty


    // ------------------------------------------------
    // Assertion
    // ------------------------------------------------

    assert_req_ack:
        assert property (req_ack_property)
        else $error("REQ was not followed by ACK");


endmodule