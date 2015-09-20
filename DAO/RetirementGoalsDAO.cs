using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq;

namespace DAO
{
    public class RetirementGoalsDAO
    {
        public retirementgoal saveRetirementGoals(retirementgoal goals)
        {
            int status = 1;
            
            try
            {
                dbDataContext ct = new dbDataContext();
                ct.retirementgoals.InsertOnSubmit(goals);
                ct.SubmitChanges();
            }
            catch (Exception e)
            {
                status = 0;
                string str = e.Message;
            }

            if (status == 0)
            {
                goals = null;
            }
            
            return goals;
        }

        public retirementgoal updateRetirementGoals(retirementgoal goals)
        {
            retirementgoal retrievedGoal = null;

            try
            {
                dbDataContext ct = new dbDataContext();
                
                //retrieve existing retirement goal 
                var queryRetirementGoals = from sg in ct.retirementgoals
                                       where sg.caseid == goals.caseid
                                       && sg.selforspouse == goals.selforspouse
                                       select sg;
                foreach (retirementgoal sgoals in queryRetirementGoals)
                {
                    retrievedGoal = sgoals;
                }

                //update retirement goal attributes
                retrievedGoal.durationretirement = goals.durationretirement;
                retrievedGoal.futureincome = goals.futureincome;
                retrievedGoal.incomerequired = goals.incomerequired;
                retrievedGoal.intendedretirementage = goals.intendedretirementage;
                retrievedGoal.lumpsumrequired = goals.lumpsumrequired;
                retrievedGoal.maturityvalue = goals.maturityvalue;
                retrievedGoal.sourcesofincome = goals.sourcesofincome;
                retrievedGoal.total = goals.total;
                retrievedGoal.totalfirstyrincome = goals.totalfirstyrincome;
                retrievedGoal.yrstoretirement = goals.yrstoretirement;
                retrievedGoal.existingassetstotal = goals.existingassetstotal;
                retrievedGoal.inflationreturnrate = goals.inflationreturnrate;
                retrievedGoal.inflationrate = goals.inflationrate;
                retrievedGoal.retirementGoalNeeded = goals.retirementGoalNeeded;

                //delete existing assets for the retirement goal
                var queryExistingAssets = from easg in ct.existingassetrgs
                                          where easg.retirementgoalsid == retrievedGoal.id
                                       select easg;
                foreach (existingassetrg easgoals in queryExistingAssets)
                {
                    ct.existingassetrgs.DeleteOnSubmit(easgoals);
                    //ct.SubmitChanges();
                }

                //update existing assets list for the retirement goal
                if (goals.existingassetrgs != null && goals.existingassetrgs.Count > 0)
                {
                    EntitySet<existingassetrg> easgList = new EntitySet<existingassetrg>();
                    foreach (existingassetrg sgea in goals.existingassetrgs)
                    {
                        easgList.Add(sgea);
                    }
                    retrievedGoal.existingassetrgs = easgList;
                }

                ct.SubmitChanges();

            }
            catch (Exception e)
            {
                string str = e.Message;
            }

            return retrievedGoal;
        }

        public retirementgoal getRetirementGoal(string caseid, string selforspouse)
        {
            retirementgoal goal = null;

            try
            {
                dbDataContext ct = new dbDataContext();
                var queryRetirementGoals = from sg in ct.retirementgoals
                                           where sg.caseid == caseid && sg.selforspouse == selforspouse
                                           select sg;
                foreach (retirementgoal sgoals in queryRetirementGoals)
                {
                    goal = sgoals;
                }
                
            }
            catch (Exception e)
            {
                string str = e.Message;
            }

            return goal;
        }
    }
    
}
