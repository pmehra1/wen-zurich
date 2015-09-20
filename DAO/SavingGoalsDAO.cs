using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Text;

namespace DAO
{
    public class SavingGoalsDAO
    {
        public savinggoal saveSavingGoals(savinggoal goals)
        {
            int status = 1;
            
            try
            {
                dbDataContext ct = new dbDataContext();

                ct.savinggoals.InsertOnSubmit(goals);
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

        public savinggoal updateSavingGoals(savinggoal goals, int sgid)
        {
            savinggoal retrievedGoal = null;

            try
            {
                dbDataContext ct = new dbDataContext();
                
                //retrieve existing saving goal 
                var querySavingGoals = from sg in ct.savinggoals
                                       where sg.caseid == goals.caseid && sg.id == sgid
                                       select sg;
                foreach (savinggoal sgoals in querySavingGoals)
                {
                    retrievedGoal = sgoals;
                }

                //retrievedGoal = goals;
                
                //update saving goal attributes
                retrievedGoal.amtneededfv = goals.amtneededfv;
                retrievedGoal.goal = goals.goal;
                retrievedGoal.maturityvalue = goals.maturityvalue;
                retrievedGoal.regularannualcontrib = goals.regularannualcontrib;
                retrievedGoal.total = goals.total;
                retrievedGoal.yrstoaccumulate = goals.yrstoaccumulate;
                retrievedGoal.existingassetstotal = goals.existingassetstotal;
                retrievedGoal.savingGoalNeeded = goals.savingGoalNeeded;

                //delete existing assets for the saving goal
                var queryExistingAssets = from easg in ct.existingassetsgs
                                          where easg.savinggoalsid == retrievedGoal.id
                                       select easg;
                foreach (existingassetsg easgoals in queryExistingAssets)
                {
                    ct.existingassetsgs.DeleteOnSubmit(easgoals);
                    //ct.SubmitChanges();
                }

                //update existing assets list for the saving goal
                if (goals.existingassetsgs != null && goals.existingassetsgs.Count > 0)
                {
                    EntitySet<existingassetsg> easgList = new EntitySet<existingassetsg>();
                    foreach (existingassetsg sgea in goals.existingassetsgs)
                    {
                        easgList.Add(sgea);
                    }
                    retrievedGoal.existingassetsgs = easgList;
                }

                if (retrievedGoal.savingGoalNeeded == 1 || retrievedGoal.savingGoalNeeded == 0)
                {
                    var sgGoalRecords = from sgids in ct.savinggoals
                                        where sgids.caseid == goals.caseid
                                        select sgids;
                    int[] arrRecordIds = null;

                    if (sgGoalRecords != null)
                    {
                        int size = sgGoalRecords.ToArray().Length;
                        arrRecordIds = new int[size];
                    }
                    
                    int index = 0;
                    foreach (savinggoal sgl in sgGoalRecords)
                    {
                        arrRecordIds[index] = sgl.id;
                        index++;
                    }

                    var todelExistingAssets = from easg in ct.existingassetsgs
                                              where arrRecordIds.Contains(easg.savinggoalsid)
                                              select easg;
                    foreach (existingassetsg easgoals in todelExistingAssets)
                    {
                        ct.existingassetsgs.DeleteOnSubmit(easgoals);
                    }

                    var toDeleteSgGoals = from sg in ct.savinggoals
                                          where sg.caseid == goals.caseid && sg.id != sgid
                                          select sg;
                    foreach (savinggoal s in toDeleteSgGoals)
                    {
                        ct.savinggoals.DeleteOnSubmit(s);
                    }
                }

                ct.SubmitChanges();

            }
            catch (Exception e)
            {
                string str = e.Message;
            }

            return retrievedGoal;
        }

        public int deleteSavingGoals(int sgid)
        {
            int status = 1;
            savinggoal retrievedGoal = null;

            try
            {
                dbDataContext ct = new dbDataContext();

                //retrieve existing saving goal 
                var querySavingGoals = from sg in ct.savinggoals
                                       where sg.id == sgid
                                       select sg;
                foreach (savinggoal sgoals in querySavingGoals)
                {
                    retrievedGoal = sgoals;
                }

                //retrievedGoal = goals;

                //update saving goal attributes
                retrievedGoal.deleted = true;

                ct.SubmitChanges();

            }
            catch (Exception e)
            {
                string str = e.Message;
                status = 0;
            }

            return status;

        }

        public List<savinggoal> getSavingGoal(string caseid)
        {
            List<savinggoal> goal = new List<savinggoal>();

            try
            {
                dbDataContext ct = new dbDataContext();
                var querySavingGoals = from sg in ct.savinggoals
                                           where sg.caseid == caseid && sg.deleted == false
                                           select sg;
                foreach (savinggoal sgoals in querySavingGoals)
                {
                    goal.Add(sgoals);
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
