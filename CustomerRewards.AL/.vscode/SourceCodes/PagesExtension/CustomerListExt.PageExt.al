pageextension 50105 CustomerListPageExtension extends "Customer List"
{
    actions
    {
        addafter(PaymentRegistration)       //This is the super parent level
        {
            action(RewardLevelPage)
            {
                ApplicationArea = All;
                Caption = 'Show Reward Page';
                Promoted = true;
                PromotedCategory = Process;     //this is the immediate parent level
                PromotedIsBig = true;
                Image = Sales;
                ToolTip = 'Go to rewards for manging customer rewards setup.';

                trigger OnAction()
                var
                    rewardPage: Page RewardLevel;
                begin
                    rewardPage.Run();
                end;
            }

        }
    }
}

