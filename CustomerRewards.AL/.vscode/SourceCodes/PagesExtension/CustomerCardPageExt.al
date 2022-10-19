pageextension 50106 CustomerCardPageExtension extends "Customer Card"
{
    //SourceTable = RewardLevel;
    layout
    {
        // Add changes to page layout here
        addafter("Name 2")
        {
            field("Reward Level"; GetRewardLevel)
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Customer Reward Level';
                ToolTip = 'This is the reward l';

            }
            field("Reward Points"; rec."Reward Points")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    local procedure GetRewardLevel(): Code[10]
    var
        rewards: Record RewardLevel;
    begin
        rewards.Reset();
        rewards.SetFilter("Minimum Reward Points", '<=%1', Rec."Reward Points");
        rewards.SetCurrentKey("Minimum Reward Points");
        rewards.SetAscending("Minimum Reward Points", false);
        if rewards.FindSet() then begin
            exit(rewards."Level Name");
        end;
    end;
}

//Creating event to manipulate DB data

codeunit 50106 "Customer Rewards Ext. Mgt"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLine', '', false, false)]
    local procedure OnAfterPostSalesLine(var SalesLine: Record "Sales Line"; var SalesInvLine: Record "Sales Invoice Line");
    var
        totalAmount: Decimal;
        totalPoint: Integer;
        customer: Record Customer;
    begin
        totalAmount := SalesInvLine.Quantity * SalesInvLine."Unit Price";
        totalPoint := totalAmount DIV 100;

        if customer.Get(SalesLine."Sell-to Customer No.") then begin
            customer."Reward Points" := customer."Reward Points" + totalPoint;
            customer.Modify(true);
        end;

    end;
}