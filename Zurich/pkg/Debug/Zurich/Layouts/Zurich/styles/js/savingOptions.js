            
            var lowest = 2;
            var low = 4;
            var high = 6;
            var highest = 8;
            var regularSumValue1 = 0;
            var regularSumValue2 = 0;
            var regularSumValue3 = 0;
            var regularSumValue4 = 0;

            var lumpSumValue1 = 0;
            var lumpSumValue2 = 0;
            var lumpSumValue3 = 0;
            var lumpSumValue4 = 0;

function calculateSavingOptions(shortfall, yearsOfRetirement, moduleName) {

    if (shortfall > 0) {
        $("#canvasTable").hide();
    }
    else
        $("#canvasTable").show();

    shortfall = Math.abs(shortfall);
    var typeOfGoal = "";
    
        switch (moduleName) {
            case 1:
                {
                    typeOfGoal="Investment Goal"
                    $('#canvasText').text(calculateCanvasHeaderTextForShortfall(typeOfGoal, shortfall, yearsOfRetirement));
                    $('#canvasText').css('color', 'red');
                    regularSumValue1 = calculateRegularSum(shortfall, lowest, yearsOfRetirement);
                    regularSumValue2 = calculateRegularSum(shortfall, low, yearsOfRetirement);
                    regularSumValue3 = calculateRegularSum(shortfall, high, yearsOfRetirement);
                    regularSumValue4 = calculateRegularSum(shortfall, highest, yearsOfRetirement);


                    lumpSumValue1 = calculateLumpSum(shortfall, lowest, yearsOfRetirement);
                    lumpSumValue2 = calculateLumpSum(shortfall, low, yearsOfRetirement);
                    lumpSumValue3 = calculateLumpSum(shortfall, high, yearsOfRetirement);
                    lumpSumValue4 = calculateLumpSum(shortfall, highest, yearsOfRetirement);
                };
                break;
            case 2:
                {
                    typeOfGoal = "Retirement Goal"
                    $('#canvasText').text(calculateCanvasHeaderTextForShortfall(typeOfGoal, shortfall, yearsOfRetirement));
                    $('#canvasText').css('color', 'red');

                    regularSumValue1 = calculateRegularSumRetirement(shortfall, lowest, yearsOfRetirement);
                    regularSumValue2 = calculateRegularSumRetirement(shortfall, low, yearsOfRetirement);
                    regularSumValue3 = calculateRegularSumRetirement(shortfall, high, yearsOfRetirement);
                    regularSumValue4 = calculateRegularSumRetirement(shortfall, highest, yearsOfRetirement);


                    lumpSumValue1 = calculateLumpSumRetirement(shortfall, lowest, yearsOfRetirement);
                    lumpSumValue2 = calculateLumpSumRetirement(shortfall, low, yearsOfRetirement);
                    lumpSumValue3 = calculateLumpSumRetirement(shortfall, high, yearsOfRetirement);
                    lumpSumValue4 = calculateLumpSumRetirement(shortfall, highest, yearsOfRetirement);

                };
                break;
            case 3:
                {
                    typeOfGoal = "Education Goal"
                    $('#canvasText').text(calculateCanvasHeaderTextForShortfall(typeOfGoal, shortfall, yearsOfRetirement));
                    $('#canvasText').css('color', 'red');

                    regularSumValue1 = calculateRegularSumEducationGoal(shortfall, lowest, yearsOfRetirement);
                    regularSumValue2 = calculateRegularSumEducationGoal(shortfall, low, yearsOfRetirement);
                    regularSumValue3 = calculateRegularSumEducationGoal(shortfall, high, yearsOfRetirement);
                    regularSumValue4 = calculateRegularSumEducationGoal(shortfall, highest, yearsOfRetirement);


                    lumpSumValue1 = calculateLumpSumEducationGoal(shortfall, lowest, yearsOfRetirement);
                    lumpSumValue2 = calculateLumpSumEducationGoal(shortfall, low, yearsOfRetirement);
                    lumpSumValue3 = calculateLumpSumEducationGoal(shortfall, high, yearsOfRetirement);
                    lumpSumValue4 = calculateLumpSumEducationGoal(shortfall, highest, yearsOfRetirement);
                };
                break;
            default:
                break;
        }
    }


    function calculateCanvasHeaderTextForShortfall(typeOfGoal, shortfall, yearsOfRetirement) {
        var savingOptionText = "Ways to achieve your " + typeOfGoal + " of $" + fixedToZero(shortfall) + " in " + yearsOfRetirement + " years";
        return savingOptionText;
    }



 function calculateRegularSum(shortfall, investmentRate, yearsToGo)
        {
            var step1 = shortfall * (investmentRate / 100);
            var step2 = 1 + (investmentRate / 100);
            var step3 = Math.pow(step2, (yearsToGo + 1));
            var step4 = 1 + (investmentRate / 100);
            var step5 = step3 - step4;
            var step6 = 0;
            if (step5 != 0)
                step6 = step1 / step5;
            return roundOff(step6);
        }


        function calculateLumpSum(shortfall, investmentRate, yearsToGo)
        {
            var step1 = shortfall;
            var step2 = 1 + (investmentRate / 100);
            var step3 = Math.pow(step2, yearsToGo);

            var step4 = 0;
            if (step3 != 0)
                step4 = step1 / step3;
            return roundOff(step4);
        }


        function calculateLumpSumRetirement(shortfall, investmentRate, yearsToGo)
        {
            var step1 = (1 + investmentRate / 100);
            var step2 = Math.pow(step1, yearsToGo);
            var step3 = 0;

            if (step2 != 0)
                step3 = shortfall / step2;
            return roundOff(step3);

        }

        function calculateRegularSumRetirement(shortfall, investmentRate, yearsToGo)
        {
            var step1 = shortfall * (investmentRate / 100);
            var step2 = (1 + (investmentRate / 100));
            var step3 = Math.pow(step2, (yearsToGo + 1));
            var step4 = step3 - step2;
            var step6 = 0;
            if (step4 != 0)
                step6 = step1 / step4;
            return roundOff(step6);
        }

        function calculateLumpSumEducationGoal(shortfall, investmentRate, yearsToGo)
        {
            var step1 = (1 + investmentRate / 100);
            var step2 = Math.pow(step1, yearsToGo);
            var step3 = 0;

            if (step2 != 0)
                step3 = shortfall / step2;
            return roundOff(step3);

        }

        function calculateRegularSumEducationGoal( shortfall, investmentRate,  yearsToGo)
        {
            var step1 = shortfall * (investmentRate / 100);
            var step2 = (1 + (investmentRate / 100));
            var step3 = Math.pow(step2, (yearsToGo + 1));
            var step4 = step3 - step2;
            var step6 = 0;
            if (step4 != 0)
                step6 = step1 / step4;
            return roundOff(step6);
        }


        function roundOff(param)
        {
            if (param == 0)
            {
                return param;
            }
            else
            {
                var calc = Math.round(param * 100) / 100;
                return param;
            }
            
        }