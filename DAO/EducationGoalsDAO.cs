using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Text;

namespace DAO
{
    public class EducationGoalsDAO
    {
        public educationgoal saveEducationGoals(educationgoal goals)
        {
            int status = 1;

            try
            {
                dbDataContext ct = new dbDataContext();
                ct.educationgoals.InsertOnSubmit(goals);
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

        public educationgoal updateEducationGoals(educationgoal goals, int egid)
        {
            educationgoal retrievedGoal = null;

            try
            {
                dbDataContext ct = new dbDataContext();

                //retrieve existing education goal 
                var queryEducationGoals = from sg in ct.educationgoals
                                       where sg.caseid == goals.caseid && sg.id == egid
                                       select sg;
                foreach (educationgoal sgoals in queryEducationGoals)
                {
                    retrievedGoal = sgoals;
                }

                //update education goal attributes
                retrievedGoal.agefundsneeded = goals.agefundsneeded;
                retrievedGoal.currentage = goals.currentage;
                retrievedGoal.maturityvalue = goals.maturityvalue;
                retrievedGoal.nameofchild = goals.nameofchild;
                retrievedGoal.noofyrstosave = goals.noofyrstosave;
                retrievedGoal.total = goals.total;
                retrievedGoal.existingassetstotal = goals.existingassetstotal;
                retrievedGoal.futurecost = goals.futurecost;
                retrievedGoal.presentcost = goals.presentcost;
                retrievedGoal.inflationrate = goals.inflationrate;
                retrievedGoal.educationGoalNeeded = goals.educationGoalNeeded;

                retrievedGoal.countryofstudyid = goals.countryofstudyid;

                //delete existing assets for the education goal
                var queryExistingAssets = from easg in ct.existingassetegs
                                          where easg.educationgoalsid == retrievedGoal.id
                                          select easg;
                foreach (existingasseteg easgoals in queryExistingAssets)
                {
                    ct.existingassetegs.DeleteOnSubmit(easgoals);
                    //ct.SubmitChanges();
                }

                //update existing assets list for the education goal
                if (goals.existingassetegs != null && goals.existingassetegs.Count > 0)
                {
                    EntitySet<existingasseteg> easgList = new EntitySet<existingasseteg>();
                    foreach (existingasseteg sgea in goals.existingassetegs)
                    {
                        easgList.Add(sgea);
                    }
                    retrievedGoal.existingassetegs = easgList;
                }

                if (retrievedGoal.educationGoalNeeded == 1 || retrievedGoal.educationGoalNeeded == 0)
                {
                    var eduGoalRecords = from edug in ct.educationgoals
                                         where edug.caseid == goals.caseid
                                         select edug;
                    int[] arrRecordIds = null;
                    
                    if (eduGoalRecords != null)
                    {
                        int size = eduGoalRecords.ToArray().Length;
                        arrRecordIds = new int[size];
                    }
                    int index = 0;
                    foreach (educationgoal egl in eduGoalRecords)
                    {
                        arrRecordIds[index] = egl.id;
                        index++;
                    }
                    
                    var todelExistingAssets = from easg in ct.existingassetegs
                                              where arrRecordIds.Contains(easg.educationgoalsid)
                                              select easg;
                    foreach (existingasseteg easgoals in todelExistingAssets)
                    {
                        ct.existingassetegs.DeleteOnSubmit(easgoals);
                    }
                    
                    var toDelEducationGoals = from sg in ct.educationgoals
                                              where sg.caseid == goals.caseid && sg.id != egid
                                              select sg;
                    foreach (educationgoal s in toDelEducationGoals)
                    {
                        ct.educationgoals.DeleteOnSubmit(s);
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

        public int deleteEducationGoal(int egid)
        {
            int status = 1;
            educationgoal retrievedGoal = null;

            try
            {
                dbDataContext ct = new dbDataContext();

                //retrieve existing education goal 
                var queryEducationGoals = from sg in ct.educationgoals
                                          where sg.id == egid
                                          select sg;
                foreach (educationgoal sgoals in queryEducationGoals)
                {
                    retrievedGoal = sgoals;
                }

                //update education goal attributes
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

        public List<educationgoal> getEducationGoal(string caseid)
        {
            List<educationgoal> goal = new List<educationgoal>();

            try
            {
                dbDataContext ct = new dbDataContext();
                var queryEducationGoals = from sg in ct.educationgoals
                                       where sg.caseid == caseid && sg.deleted == false
                                       select sg;
                foreach (educationgoal sgoals in queryEducationGoals)
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

        public EntitySet<countrycostofeducation> getCountryCostOfEducation()
        {
            EntitySet<countrycostofeducation> cced = new EntitySet<countrycostofeducation>();

            try
            {
                dbDataContext ct = new dbDataContext();
                var queryCountry = from sg in ct.countrycostofeducations
                                   select sg;
                
                foreach (countrycostofeducation cc in queryCountry)
                {
                    cced.Add(cc);
                }

            }
            catch (Exception e)
            {
                string str = e.Message;
            }

            return cced;
        }
    }
}
