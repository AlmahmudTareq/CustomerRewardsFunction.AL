page 50104 RewardLevel
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = RewardLevel;
    Caption = 'Reward Level';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Level Name"; Rec."Level Name")
                {
                    Caption = 'Level Name';
                    ShowMandatory = true;
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field("Minimum Reward Points"; Rec."Minimum Reward Points")
                {
                    Caption = 'Minium Reward point';
                    ShowMandatory = true;
                    NotBlank = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin

                        CheckRewardPointValue();

                    end;


                }
            }
        }
    }
    local procedure CheckRewardPointValue()
    var
        myInt: Integer;
    begin
        if Rec."Minimum Reward Points" MOD 10 <> 0 then
            Error('Value should be the multipliable by 10');
    end;
}
