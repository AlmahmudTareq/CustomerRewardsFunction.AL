table 50103 RewardLevel
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Level Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            trigger OnValidate();
            begin
                if "Level Name" = '' then
                    Error('Can not keep Level Name blank');
            end;

        }
        field(2; "Minimum Reward Points"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                if existsRewardPoints(rec."Minimum Reward Points") then begin
                    Error('Reward point %1 is being used in different reward level. So please enter different reward.', Rec."Minimum Reward Points");
                end;

                if Rec."Minimum Reward Points" <= 0 then
                    Error('Reward Point Cannot be negative');
                if Rec."Minimum Reward Points" >= 1000 then
                    Error('Reward Point Cannot be larger than 1000');

                //if existsRewardPoints(rec."Minimum Reward Points") + 50 <= Rec."Minimum Reward Points" then
                if (existsRewardPoint(rec."Minimum Reward Points") + 50 < Rec."Minimum Reward Points") and (existsRewardPoint(rec."Minimum Reward Points") + 50 > Rec."Minimum Reward Points") then
                    Error('Enter a value that is at least 50 greater/less than any existing record');

                // if existsRewardPoint(rec."Minimum Reward Points") + 50 > Rec."Minimum Reward Points" then
                //     Error('Enter a value that is at least 50 greater than existing record');

            end;

        }
    }

    keys
    {
        key(PK; "Level Name")
        {
            Clustered = true;

        }
    }

    local procedure existsRewardPoints(point: Integer): Boolean
    var
        rewardLevel: Record RewardLevel;
    begin
        rewardLevel.Reset();
        rewardLevel.SetFilter("Minimum Reward Points", '%1', point);
        if rewardLevel.FindFirst() then exit(true);
    end;

    local procedure existsRewardPoint(pointPlus50: Decimal): Integer
    var
        rewardLevel: Record RewardLevel;
    begin
        rewardLevel.Reset();
        rewardLevel.SetFilter("Minimum Reward Points", '%1', pointPlus50);
        if rewardLevel.FindFirst() then exit(pointPlus50);
    end;

    // local procedure existsRewardPointsInt(pointDiff: Integer): Integer
    // var
    //     rewardLevel: Record RewardLevel;
    // begin
    //     rewardLevel.Reset();
    //     rewardLevel.SetFilter("Minimum Reward Points", '%1', pointDiff);
    //     if rewardLevel.FindFirst() then exit();
    // end;

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}