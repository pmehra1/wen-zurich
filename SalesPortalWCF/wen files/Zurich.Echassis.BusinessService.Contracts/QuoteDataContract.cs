// -----------------------------------------------------------------------
// <copyright file="QuoteDataContract.cs" company="Microsoft">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------

namespace Zurich.Echassis.BusinessService.Contracts
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Text;
    using System.Runtime.Serialization;
    using System.ServiceModel;

    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    [DataContract]
    public class QuoteDataContract : BaseRequestDataContract
    {
        [DataMember]
        public string QuoteId { get; set; }
        [DataMember]
        public string QuoteStatus { get; set; }
        [DataMember]
        public string CaseId { get; set; }
        [DataMember]
        public string CloneQuoteId { get; set; }
        [DataMember]
        public NewBusinessInvocationRequest IntegrationRequestData { get; set; }
        [DataMember]
        public User User { get; set; }
        [DataMember]
        public byte[] IllustrationDoc { get; set; }
        [DataMember]
        public string DocumentName { get; set; }
        [DataMember]
        public string DocumentType { get; set; }
        [DataMember]
        public string QuoteDescription { get; set; }
        [DataMember]
        public string UserID { get; set; }
        [DataMember]
        public NewBusiness QuoteMetaData { get; set; }
        [DataMember]
        public string ClonedFlag { get; set; }
        [DataMember]
        public string Deleted { get; set; }
        [DataMember]
        public string ModuleName { get; set; }
    }

    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    [DataContract]
    public class QuoteResponseDataContract : BaseResponseDataContract
    {
        [DataMember]
        public DataSet Data { get; set; }

        [DataMember]
        public int Count { get; set; }   
    }

    [DataContract]
    public class Benefit
    {
        [DataMember]
        public string id { get; set; }
        [DataMember]
        public string name { get; set; }
        [DataMember]
        public string[] specificationIds { get; set; }

        public Benefit() { }
    }

    [DataContract]
    public enum DistributorStereotype
    {
       [EnumMember]
        Agency = 1,
       [EnumMember]
        Bank = 2,
       [EnumMember]
        ExpatFA = 3,
       [EnumMember]  
        LocalFA = 4
    }

    [DataContract]
    public class Distributor
    {
        [DataMember]
        public string id { get; set; }
        [DataMember]
        public DistributorStereotype stereotypeId { get; set; }
        [DataMember]
        public string name { get; set; }
        [DataMember]
        public string repNumber { get; set; }

        public Distributor()
        {

        }
    }

    [DataContract]
    public class Fund
    {
        [DataMember]
        public string id { get; set; }
        [DataMember]
        public string name { get; set; }
        [DataMember]
        public string[] specificationIds { get; set; }
        [DataMember]
        public float allocation { get; set; }

        public Fund()
        {

        }
    }

    [DataContract]
    public enum NewBusinessStatus
    {
        [EnumMember]
        NewQuote = 0,
        [EnumMember]
        IncompleteQuote = 1,
        [EnumMember]
        ValidQuote = 2,
        [EnumMember]
        CompletedQuote = 3
    }

    [DataContract]
    public class NewBusiness
    {
        [DataMember]
        public string id { get; set; }
        [DataMember]
        public string caseId { get; set; }
        [DataMember]
        public string startDate { get; set; }
        [DataMember]
        public string sumAssured { get; set; }
        [DataMember]
        public string premium { get; set; }
        [DataMember]
        public NewBusinessStatus status { get; set; }
        [DataMember]
        public Person applicant { get; set; }
        [DataMember]
        public Person[] livesAssured { get; set; }
        [DataMember]
        public Fund[] funds { get; set; }
        [DataMember]
        public ProductType productType { get; set; }
        [DataMember]
        public Signatory[] signatories { get; set; }

        public NewBusiness()
        {

        }
    }

    [DataContract]
    public enum NewBusinessInvocationType
    {
        [EnumMember]
        NewQuote = 0,
        [EnumMember]
        ExistingQuote = 1,
        [EnumMember]
        CloneQuote = 2,
        [EnumMember]
        DeleteQuote = 3
    }

    [DataContract]
    public class NewBusinessInvocationRequest
    {
        [DataMember]
        public string quoteId { get; set; }
        [DataMember]
        public string caseId { get; set; }
        [DataMember]
        public string clonedQuoteId { get; set; }
        [DataMember]
        public NewBusinessInvocationType quoteType { get; set; }
        [DataMember]
        public User user { get; set; }
        [DataMember]
        public Distributor distributor { get; set; }
        [DataMember]
        public Person applicant { get; set; }
        [DataMember]
        public Fund[] funds { get; set; }

        public NewBusinessInvocationRequest()
        {

        }
    }

    [DataContract]
    public class Person
    {
        public enum Gender
        {
            [EnumMember]
            Male = 0,
            [EnumMember]
            Female = 1
        }

        [DataContract]
        public enum Occupation
        {
            #region Occupation List
            [EnumMember]
            Other = 0,
            [EnumMember]
            Accountant = 1,
            [EnumMember]
            Accounts_Assistant = 2,
            [EnumMember]
            ActorActress_no_stunt = 3,
            [EnumMember]
            Actuary = 4,
            [EnumMember]
            Admin_Assistant = 5,
            [EnumMember]
            Administrator_Officebased = 6,
            [EnumMember]
            Advertiser_Advertising_Agent = 7,
            [EnumMember]
            Agent_estatetravelinsurance = 8,
            [EnumMember]
            Aircraft_Engineer = 9,
            [EnumMember]
            Airport_Security_unarmed = 10,
            [EnumMember]
            Architect = 11,
            [EnumMember]
            Artist = 12,
            [EnumMember]
            Athlete_track_field_only = 13,
            [EnumMember]
            Auctioneer = 14,
            [EnumMember]
            Auditor = 15,
            [EnumMember]
            Author = 16,
            [EnumMember]
            Baggage_Porter = 17,
            [EnumMember]
            Baker = 18,
            [EnumMember]
            Bank_Teller = 19,
            [EnumMember]
            BankerBank_Officer = 20,
            [EnumMember]
            Barber = 21,
            [EnumMember]
            Bartender = 22,
            [EnumMember]
            Beautician = 23,
            [EnumMember]
            Blacksmith = 24,
            [EnumMember]
            Boat_Man_Ferryman = 25,
            [EnumMember]
            Bomb_Disposal_Specialist = 26,
            [EnumMember]
            Book_Keeper = 27,
            [EnumMember]
            Broker_InsuranceMoneyStock = 28,
            [EnumMember]
            Bus_Inspector = 29,
            [EnumMember]
            Butcher = 30,
            [EnumMember]
            Cable_splicer_Lineman = 31,
            [EnumMember]
            Cabin_Crew_Airlines = 32,
            [EnumMember]
            Canteen_Assistant_Operator = 33,
            [EnumMember]
            Car_Park_Attendant = 34,
            [EnumMember]
            Carpenter = 35,
            [EnumMember]
            Cashier = 36,
            [EnumMember]
            Chambermaid = 37,
            [EnumMember]
            Chauffeur = 38,
            [EnumMember]
            Chef_Cook = 39,
            [EnumMember]
            Chemist = 40,
            [EnumMember]
            Chief_Executive_Officer = 41,
            [EnumMember]
            Civil_Engineer = 42,
            [EnumMember]
            Cleaner = 43,
            [EnumMember]
            Clerk_Clerical_Officer = 44,
            [EnumMember]
            Clinic_Assistant_non_nursing_staff = 45,
            [EnumMember]
            Coach_Sports = 46,
            [EnumMember]
            Computer_Analyst_Programmer = 47,
            [EnumMember]
            Construction_Foreman = 48,
            [EnumMember]
            Construction_Site_Worker = 49,
            [EnumMember]
            Consultant = 50,
            [EnumMember]
            Craftsman = 51,
            [EnumMember]
            Crane_DriverTower_Crane_Operator = 52,
            [EnumMember]
            Cruise_Crew_all_crew_members_working_onboard_of_cruise_ship_in_customer_services_only = 53,
            [EnumMember]
            Curator_museum = 54,
            [EnumMember]
            Customer_Service_Officer = 55,
            [EnumMember]
            Dancer_Professional = 56,
            [EnumMember]
            Dental_Assistant_Nurse = 57,
            [EnumMember]
            Dentist = 58,
            [EnumMember]
            Designer_Interior = 59,
            [EnumMember]
            Despatch_Delivery_Man = 60,
            [EnumMember]
            Detective = 61,
            [EnumMember]
            Diplomat = 62,
            [EnumMember]
            Disc_Jockey = 63,
            [EnumMember]
            Diving_Instructor = 64,
            [EnumMember]
            Diver = 65,
            [EnumMember]
            Dock_Worker = 66,
            [EnumMember]
            Doctor = 67,
            [EnumMember]
            Dog_Trainer = 68,
            [EnumMember]
            Demolition_Worker = 69,
            [EnumMember]
            Draughtsman = 70,
            [EnumMember]
            Driver_Bus_Taxi_van_coach_private_car_ambulance = 71,
            [EnumMember]
            Driver_Heavy_Vehicle_Truck_Lorry_Container = 72,
            [EnumMember]
            Driving_Instructor = 73,
            [EnumMember]
            Economist = 74,
            [EnumMember]
            Editor = 75,
            [EnumMember]
            Electrician_without_Height_involvement = 76,
            [EnumMember]
            Electrician_with_Height_involvement = 77,
            [EnumMember]
            Engineer = 78,
            [EnumMember]
            Engineer_Admin_Office_Based = 79,
            [EnumMember]
            Entertainer = 80,
            [EnumMember]
            Executive_Office_Based = 81,
            [EnumMember]
            Factor_Worker = 82,
            [EnumMember]
            Fashion_Designer = 83,
            [EnumMember]
            Fashion_Model = 84,
            [EnumMember]
            Financial_Controller = 85,
            [EnumMember]
            Financial_Planner_Adviser = 86,
            [EnumMember]
            Fireman = 87,
            [EnumMember]
            Fisherman_River_Lake_Coastal = 88,
            [EnumMember]
            Fisherman_Offshore = 89,
            [EnumMember]
            Fishmonger = 90,
            [EnumMember]
            Fitness_Instructor = 91,
            [EnumMember]
            Florist = 92,
            [EnumMember]
            Forklift_Driver = 93,
            [EnumMember]
            Garage_Worker = 94,
            [EnumMember]
            Gardener = 95,
            [EnumMember]
            General_Manager = 96,
            [EnumMember]
            General_Worker = 97,
            [EnumMember]
            Goldsmith = 98,
            [EnumMember]
            Hairstylist = 99,
            [EnumMember]
            Hawker = 100,
            [EnumMember]
            Hotel_Public_Relations_Officer = 101,
            [EnumMember]
            Housewife = 102,
            [EnumMember]
            Jeweller = 103,
            [EnumMember]
            Jockey_Flat_Racing = 104,
            [EnumMember]
            Journalist_local_no_war_zone = 105,
            [EnumMember]
            Judge = 106,
            [EnumMember]
            Juvenile = 107,
            [EnumMember]
            Labourer = 108,
            [EnumMember]
            Landscape_Artist = 109,
            [EnumMember]
            Lawyer = 110,
            [EnumMember]
            Lecturer = 111,
            [EnumMember]
            Legal_AdviserOfficerConsultant = 112,
            [EnumMember]
            Librarian = 113,
            [EnumMember]
            Life_Guard = 114,
            [EnumMember]
            Locksmith = 115,
            [EnumMember]
            Loss_Adjustor = 116,
            [EnumMember]
            Machine_Operator = 117,
            [EnumMember]
            Machinist = 118,
            [EnumMember]
            Manager_Office_Based = 119,
            [EnumMember]
            Managing_Director = 120,
            [EnumMember]
            Marketing_Staff_Office_Based = 121,
            [EnumMember]
            Masseur_Masseuse_International_Hotel_Health_Spa = 122,
            [EnumMember]
            Mechanic_without_Height_Involvement = 123,
            [EnumMember]
            Mechanic_with_Height_Involvement = 124,
            [EnumMember]
            Military_AdministrativeClerical_Functions_Not_Combat = 125,
            [EnumMember]
            Military_Air_Force = 126,
            [EnumMember]
            Military_Commando = 127,
            [EnumMember]
            Military_Naval_Diver_Frogman_no_bomb_disposaldemolition = 128,
            [EnumMember]
            Military_Naval_Diver_with_disposal = 129,
            [EnumMember]
            Minister_of_Religion = 130,
            [EnumMember]
            Motor_Cycle_Delivery_Rider = 131,
            [EnumMember]
            Motor_Vehicle_Dealer = 132,
            [EnumMember]
            Musician_Entertainer = 133,
            [EnumMember]
            National_Serviceman = 134,
            [EnumMember]
            News_Broadcaster = 135,
            [EnumMember]
            Nurse = 136,
            [EnumMember]
            Odd_Job_Labourer = 137,
            [EnumMember]
            Oil_Refinery_Admin_Personnel = 138,
            [EnumMember]
            Oil_Refinery_Worker_Offshore = 139,
            [EnumMember]
            Oil_Refinery_Worker_Inland = 140,
            [EnumMember]
            Optician = 141,
            [EnumMember]
            Optometrist = 142,
            [EnumMember]
            Packer = 143,
            [EnumMember]
            Painter_Indoor = 144,
            [EnumMember]
            Painter_External_use_scaffold_above_20_ft = 145,
            [EnumMember]
            Pastor = 146,
            [EnumMember]
            Pharmacist = 147,
            [EnumMember]
            Photographer_StudioIndoor = 148,
            [EnumMember]
            Photographer_Outdoor = 149,
            [EnumMember]
            Pilot_Commercial_Passenger = 150,
            [EnumMember]
            Pilot_Private_other_form_of_flying = 151,
            [EnumMember]
            Plumber = 152,
            [EnumMember]
            Policeman_Officer_Gurkha_Officer_excl_Traffic_Police_and_Mobile_Squad = 153,
            [EnumMember]
            Police_Mobile_Squad = 154,
            [EnumMember]
            Politician = 155,
            [EnumMember]
            Postman = 156,
            [EnumMember]
            President_Company = 157,
            [EnumMember]
            Principal_School = 158,
            [EnumMember]
            Prison_Officer_Warden = 159,
            [EnumMember]
            Promoter_Sales = 160,
            [EnumMember]
            Receptionist = 161,
            [EnumMember]
            Remisier = 162,
            [EnumMember]
            Renovation_Contractor = 163,
            [EnumMember]
            Reporter_local_no_flying_no_war_zone = 164,
            [EnumMember]
            Research_Development_Engineer = 165,
            [EnumMember]
            Retiree = 166,
            [EnumMember]
            Sales_Personnel_Outdoor = 167,
            [EnumMember]
            Seaman_Sailor = 168,
            [EnumMember]
            Seamstress = 169,
            [EnumMember]
            Secretary = 170,
            [EnumMember]
            Security_Guard_Armed = 171,
            [EnumMember]
            Security_Guard_Unarmed = 172,
            [EnumMember]
            Selfemployed_nonmanual_intensive = 173,
            [EnumMember]
            Shipping_Admin_Personnel = 174,
            [EnumMember]
            Shop_Assistant_Manager_Administrative = 175,
            [EnumMember]
            Singer_in_reputable_hotels_lounge = 176,
            [EnumMember]
            Social_Worker = 177,
            [EnumMember]
            Sole_Proprietor = 178,
            [EnumMember]
            Statistician = 179,
            [EnumMember]
            Store_Keeper = 180,
            [EnumMember]
            Student = 181,
            [EnumMember]
            Supervisor = 182,
            [EnumMember]
            Surgeon = 183,
            [EnumMember]
            Surveyor = 184,
            [EnumMember]
            Tailor = 185,
            [EnumMember]
            Teacher_Academic = 186,
            [EnumMember]
            Teacher_PE_full_time = 187,
            [EnumMember]
            Technical_Officer_Admin = 188,
            [EnumMember]
            Technician_Qualified = 189,
            [EnumMember]
            Telephone_Operator = 190,
            [EnumMember]
            Telemarketeer = 191,
            [EnumMember]
            Tour_Guide = 192,
            [EnumMember]
            Traffic_Police = 193,
            [EnumMember]
            Tutor_Private = 194,
            [EnumMember]
            Typist = 195,
            [EnumMember]
            Underwriter = 196,
            [EnumMember]
            Unemployed = 197,
            [EnumMember]
            Veterinary_Surgeon = 198,
            [EnumMember]
            Waiter_Waitress = 199,
            [EnumMember]
            Welder_Not_underwateroilgas_no_height_involvement = 200,
            [EnumMember]
            Window_Cleaner_above_20_ft = 201,
            [EnumMember]
            Zoo_Keeper = 202
            #endregion
        }
        [DataContract]
        public enum Country
        {
            #region Country Codes
            [EnumMember]
            AX = 0,
            [EnumMember]
            AF = 1,
            [EnumMember]
            AL = 2,
            [EnumMember]
            DZ = 3,
            [EnumMember]
            AS = 4,
            [EnumMember]
            AD = 5,
            [EnumMember]
            AO = 6,
            [EnumMember]
            AI = 7,
            [EnumMember]
            AQ = 8,
            [EnumMember]
            AG = 9,
            [EnumMember]
            AR = 10,
            [EnumMember]
            AM = 11,
            [EnumMember]
            AW = 12,
            [EnumMember]
            AU = 13,
            [EnumMember]
            AT = 14,
            [EnumMember]
            AZ = 15,
            [EnumMember]
            BS = 16,
            [EnumMember]
            BH = 17,
            [EnumMember]
            BD = 18,
            [EnumMember]
            BB = 19,
            [EnumMember]
            BY = 20,
            [EnumMember]
            BE = 21,
            [EnumMember]
            BZ = 22,
            [EnumMember]
            BJ = 23,
            [EnumMember]
            BM = 24,
            [EnumMember]
            BT = 25,
            [EnumMember]
            BO = 26,
            [EnumMember]
            BA = 27,
            [EnumMember]
            BW = 28,
            [EnumMember]
            BV = 29,
            [EnumMember]
            BR = 30,
            [EnumMember]
            IO = 31,
            [EnumMember]
            BN = 32,
            [EnumMember]
            BG = 33,
            [EnumMember]
            BF = 34,
            [EnumMember]
            BI = 35,
            [EnumMember]
            KH = 36,
            [EnumMember]
            CM = 37,
            [EnumMember]
            CA = 38,
            [EnumMember]
            CV = 39,
            [EnumMember]
            KY = 40,
            [EnumMember]
            CF = 41,
            [EnumMember]
            TD = 42,
            [EnumMember]
            CL = 43,
            [EnumMember]
            CN = 44,
            [EnumMember]
            CX = 45,
            [EnumMember]
            CC = 46,
            [EnumMember]
            CO = 47,
            [EnumMember]
            KM = 48,
            [EnumMember]
            CG = 49,
            [EnumMember]
            CD = 50,
            [EnumMember]
            CK = 51,
            [EnumMember]
            CR = 52,
            [EnumMember]
            HR = 53,
            [EnumMember]
            CU = 54,
            [EnumMember]
            CY = 55,
            [EnumMember]
            CZ = 56,
            [EnumMember]
            CI = 57,
            [EnumMember]
            DK = 58,
            [EnumMember]
            DJ = 59,
            [EnumMember]
            DM = 60,
            [EnumMember]
            DO = 61,
            [EnumMember]
            EC = 62,
            [EnumMember]
            EG = 63,
            [EnumMember]
            SV = 64,
            [EnumMember]
            GQ = 65,
            [EnumMember]
            ER = 66,
            [EnumMember]
            EE = 67,
            [EnumMember]
            ET = 68,
            [EnumMember]
            FK = 69,
            [EnumMember]
            FO = 70,
            [EnumMember]
            FJ = 71,
            [EnumMember]
            FI = 72,
            [EnumMember]
            FR = 73,
            [EnumMember]
            GF = 74,
            [EnumMember]
            PF = 75,
            [EnumMember]
            TF = 76,
            [EnumMember]
            GA = 77,
            [EnumMember]
            GM = 78,
            [EnumMember]
            GE = 79,
            [EnumMember]
            DE = 80,
            [EnumMember]
            GH = 81,
            [EnumMember]
            GI = 82,
            [EnumMember]
            GR = 83,
            [EnumMember]
            GL = 84,
            [EnumMember]
            GD = 85,
            [EnumMember]
            GP = 86,
            [EnumMember]
            GU = 87,
            [EnumMember]
            GT = 88,
            [EnumMember]
            GG = 89,
            [EnumMember]
            GN = 90,
            [EnumMember]
            GW = 91,
            [EnumMember]
            GY = 92,
            [EnumMember]
            HT = 93,
            [EnumMember]
            HM = 94,
            [EnumMember]
            HN = 95,
            [EnumMember]
            HK = 96,
            [EnumMember]
            HU = 97,
            [EnumMember]
            IS = 98,
            [EnumMember]
            IN = 99,
            [EnumMember]
            ID = 100,
            [EnumMember]
            IR = 101,
            [EnumMember]
            IQ = 102,
            [EnumMember]
            IE = 103,
            [EnumMember]
            IM = 104,
            [EnumMember]
            IL = 105,
            [EnumMember]
            IT = 106,
            [EnumMember]
            JM = 107,
            [EnumMember]
            JP = 108,
            [EnumMember]
            JE = 109,
            [EnumMember]
            JO = 110,
            [EnumMember]
            KZ = 111,
            [EnumMember]
            KE = 112,
            [EnumMember]
            KI = 113,
            [EnumMember]
            KP = 114,
            [EnumMember]
            KR = 115,
            [EnumMember]
            KW = 116,
            [EnumMember]
            KG = 117,
            [EnumMember]
            LA = 118,
            [EnumMember]
            LV = 119,
            [EnumMember]
            LB = 120,
            [EnumMember]
            LS = 121,
            [EnumMember]
            LR = 122,
            [EnumMember]
            LY = 123,
            [EnumMember]
            LI = 124,
            [EnumMember]
            LT = 125,
            [EnumMember]
            LU = 126,
            [EnumMember]
            MO = 127,
            [EnumMember]
            MK = 128,
            [EnumMember]
            MG = 129,
            [EnumMember]
            MW = 130,
            [EnumMember]
            MY = 131,
            [EnumMember]
            MV = 132,
            [EnumMember]
            ML = 133,
            [EnumMember]
            MT = 134,
            [EnumMember]
            MH = 135,
            [EnumMember]
            MQ = 136,
            [EnumMember]
            MR = 137,
            [EnumMember]
            MU = 138,
            [EnumMember]
            YT = 139,
            [EnumMember]
            MX = 140,
            [EnumMember]
            FM = 141,
            [EnumMember]
            MD = 142,
            [EnumMember]
            MC = 143,
            [EnumMember]
            MN = 144,
            [EnumMember]
            ME = 145,
            [EnumMember]
            MS = 146,
            [EnumMember]
            MA = 147,
            [EnumMember]
            MZ = 148,
            [EnumMember]
            MM = 149,
            [EnumMember]
            NA = 150,
            [EnumMember]
            NR = 151,
            [EnumMember]
            NP = 152,
            [EnumMember]
            NL = 153,
            [EnumMember]
            AN = 154,
            [EnumMember]
            NC = 155,
            [EnumMember]
            NZ = 156,
            [EnumMember]
            NI = 157,
            [EnumMember]
            NE = 158,
            [EnumMember]
            NG = 159,
            [EnumMember]
            NU = 160,
            [EnumMember]
            NF = 161,
            [EnumMember]
            MP = 162,
            [EnumMember]
            NO = 163,
            [EnumMember]
            OM = 164,
            [EnumMember]
            PK = 165,
            [EnumMember]
            PW = 166,
            [EnumMember]
            PS = 167,
            [EnumMember]
            PA = 168,
            [EnumMember]
            PG = 169,
            [EnumMember]
            PY = 170,
            [EnumMember]
            PE = 171,
            [EnumMember]
            PH = 172,
            [EnumMember]
            PN = 173,
            [EnumMember]
            PL = 174,
            [EnumMember]
            PT = 175,
            [EnumMember]
            PR = 176,
            [EnumMember]
            QA = 177,
            [EnumMember]
            RO = 178,
            [EnumMember]
            RU = 179,
            [EnumMember]
            RW = 180,
            [EnumMember]
            RE = 181,
            [EnumMember]
            BL = 182,
            [EnumMember]
            SH = 183,
            [EnumMember]
            KN = 184,
            [EnumMember]
            LC = 185,
            [EnumMember]
            MF = 186,
            [EnumMember]
            PM = 187,
            [EnumMember]
            VC = 188,
            [EnumMember]
            WS = 189,
            [EnumMember]
            SM = 190,
            [EnumMember]
            ST = 191,
            [EnumMember]
            SA = 192,
            [EnumMember]
            SN = 193,
            [EnumMember]
            RS = 194,
            [EnumMember]
            SC = 195,
            [EnumMember]
            SL = 196,
            [EnumMember]
            SG = 197,
            [EnumMember]
            SK = 198,
            [EnumMember]
            SI = 199,
            [EnumMember]
            SB = 200,
            [EnumMember]
            SO = 201,
            [EnumMember]
            ZA = 202,
            [EnumMember]
            GS = 203,
            [EnumMember]
            ES = 204,
            [EnumMember]
            LK = 205,
            [EnumMember]
            SD = 206,
            [EnumMember]
            SR = 207,
            [EnumMember]
            SJ = 208,
            [EnumMember]
            SZ = 209,
            [EnumMember]
            SE = 210,
            [EnumMember]
            CH = 211,
            [EnumMember]
            SY = 212,
            [EnumMember]
            TW = 213,
            [EnumMember]
            TJ = 214,
            [EnumMember]
            TZ = 215,
            [EnumMember]
            TH = 216,
            [EnumMember]
            TL = 217,
            [EnumMember]
            TG = 218,
            [EnumMember]
            TK = 219,
            [EnumMember]
            TO = 220,
            [EnumMember]
            TT = 221,
            [EnumMember]
            TN = 222,
            [EnumMember]
            TR = 223,
            [EnumMember]
            TM = 224,
            [EnumMember]
            TC = 225,
            [EnumMember]
            TV = 226,
            [EnumMember]
            UG = 227,
            [EnumMember]
            UA = 228,
            [EnumMember]
            AE = 229,
            [EnumMember]
            GB = 230,
            [EnumMember]
            US = 231,
            [EnumMember]
            UM = 232,
            [EnumMember]
            UY = 233,
            [EnumMember]
            UZ = 234,
            [EnumMember]
            VU = 235,
            [EnumMember]
            VA = 236,
            [EnumMember]
            VE = 237,
            [EnumMember]
            VN = 238,
            [EnumMember]
            VG = 239,
            [EnumMember]
            VI = 240,
            [EnumMember]
            WF = 241,
            [EnumMember]
            EH = 242,
            [EnumMember]
            YE = 243,
            [EnumMember]
            ZM = 244,
            [EnumMember]
            ZW = 245
            #endregion
        }
        [DataContract]
        public enum Nationality
        {
            #region Nationality Code
            [EnumMember]
            AF = 0,
            [EnumMember]
            AL = 1,
            [EnumMember]
            DZ = 2,
            [EnumMember]
            US = 3,
            [EnumMember]
            AD = 4,
            [EnumMember]
            AO = 5,
            [EnumMember]
            AG = 6,
            [EnumMember]
            AR = 7,
            [EnumMember]
            AM = 8,
            [EnumMember]
            AU = 9,
            [EnumMember]
            AT = 10,
            [EnumMember]
            AZ = 11,
            [EnumMember]
            BS = 12,
            [EnumMember]
            BH = 13,
            [EnumMember]
            BD = 14,
            [EnumMember]
            BB = 15,
            [EnumMember]
            BU = 16,
            [EnumMember]
            BW = 17,
            [EnumMember]
            BY = 18,
            [EnumMember]
            BE = 19,
            [EnumMember]
            BZ = 20,
            [EnumMember]
            BJ = 21,
            [EnumMember]
            BT = 22,
            [EnumMember]
            BO = 23,
            [EnumMember]
            BA = 24,
            [EnumMember]
            BR = 25,
            [EnumMember]
            GB = 26,
            [EnumMember]
            BN = 27,
            [EnumMember]
            BG = 28,
            [EnumMember]
            BF = 29,
            [EnumMember]
            MM = 30,
            [EnumMember]
            BI = 31,
            [EnumMember]
            KH = 32,
            [EnumMember]
            CM = 33,
            [EnumMember]
            CA = 34,
            [EnumMember]
            CV = 35,
            [EnumMember]
            CF = 36,
            [EnumMember]
            TD = 37,
            [EnumMember]
            CL = 38,
            [EnumMember]
            CN = 39,
            [EnumMember]
            CO = 40,
            [EnumMember]
            KM = 41,
            [EnumMember]
            CG = 42,
            [EnumMember]
            CR = 43,
            [EnumMember]
            HR = 44,
            [EnumMember]
            CU = 45,
            [EnumMember]
            CY = 46,
            [EnumMember]
            CZ = 47,
            [EnumMember]
            DK = 48,
            [EnumMember]
            DJ = 49,
            [EnumMember]
            DO = 50,
            [EnumMember]
            NL = 51,
            [EnumMember]
            TL = 52,
            [EnumMember]
            EC = 53,
            [EnumMember]
            EG = 54,
            [EnumMember]
            AE = 55,
            [EnumMember]
            GQ = 56,
            [EnumMember]
            ER = 57,
            [EnumMember]
            EE = 58,
            [EnumMember]
            ET = 59,
            [EnumMember]
            FJ = 60,
            [EnumMember]
            PH = 61,
            [EnumMember]
            FI = 62,
            [EnumMember]
            FR = 63,
            [EnumMember]
            GA = 64,
            [EnumMember]
            GM = 65,
            [EnumMember]
            GE = 66,
            [EnumMember]
            DE = 67,
            [EnumMember]
            GH = 68,
            [EnumMember]
            GR = 69,
            [EnumMember]
            GD = 70,
            [EnumMember]
            GT = 71,
            [EnumMember]
            GW = 72,
            [EnumMember]
            GN = 73,
            [EnumMember]
            GY = 74,
            [EnumMember]
            HT = 75,
            [EnumMember]
            HZ = 76,
            [EnumMember]
            HN = 77,
            [EnumMember]
            HU = 78,
            [EnumMember]
            IS = 79,
            [EnumMember]
            IN = 80,
            [EnumMember]
            ID = 81,
            [EnumMember]
            IR = 82,
            [EnumMember]
            IQ = 83,
            [EnumMember]
            IE = 84,
            [EnumMember]
            IL = 85,
            [EnumMember]
            IT = 86,
            [EnumMember]
            CI = 87,
            [EnumMember]
            JM = 88,
            [EnumMember]
            JP = 89,
            [EnumMember]
            JO = 90,
            [EnumMember]
            KZ = 91,
            [EnumMember]
            KE = 92,
            [EnumMember]
            KN = 93,
            [EnumMember]
            KW = 94,
            [EnumMember]
            KG = 95,
            [EnumMember]
            LA = 96,
            [EnumMember]
            LV = 97,
            [EnumMember]
            LB = 98,
            [EnumMember]
            LR = 99,
            [EnumMember]
            LY = 100,
            [EnumMember]
            LI = 101,
            [EnumMember]
            LT = 102,
            [EnumMember]
            LU = 103,
            [EnumMember]
            MK = 104,
            [EnumMember]
            MG = 105,
            [EnumMember]
            MW = 106,
            [EnumMember]
            MY = 107,
            [EnumMember]
            MV = 108,
            [EnumMember]
            ML = 109,
            [EnumMember]
            MT = 110,
            [EnumMember]
            MH = 111,
            [EnumMember]
            MR = 112,
            [EnumMember]
            MU = 113,
            [EnumMember]
            MX = 114,
            [EnumMember]
            FM = 115,
            [EnumMember]
            MD = 116,
            [EnumMember]
            MC = 117,
            [EnumMember]
            MN = 118,
            [EnumMember]
            MA = 119,
            [EnumMember]
            LS = 120,
            [EnumMember]
            MO = 121,
            [EnumMember]
            MZ = 122,
            [EnumMember]
            NA = 123,
            [EnumMember]
            NR = 124,
            [EnumMember]
            NP = 125,
            [EnumMember]
            HO = 126,
            [EnumMember]
            NZ = 127,
            [EnumMember]
            VU = 128,
            [EnumMember]
            NI = 129,
            [EnumMember]
            NG = 130,
            [EnumMember]
            NE = 131,
            [EnumMember]
            KP = 132,
            [EnumMember]
            NS = 133,
            [EnumMember]
            NO = 134,
            [EnumMember]
            OM = 135,
            [EnumMember]
            PK = 136,
            [EnumMember]
            PW = 137,
            [EnumMember]
            PA = 138,
            [EnumMember]
            PG = 139,
            [EnumMember]
            PY = 140,
            [EnumMember]
            PE = 141,
            [EnumMember]
            PL = 142,
            [EnumMember]
            PT = 143,
            [EnumMember]
            QA = 144,
            [EnumMember]
            RO = 145,
            [EnumMember]
            RU = 146,
            [EnumMember]
            RW = 147,
            [EnumMember]
            LC = 148,
            [EnumMember]
            SV = 149,
            [EnumMember]
            WS = 150,
            [EnumMember]
            SM = 151,
            [EnumMember]
            ST = 152,
            [EnumMember]
            SA = 153,
            [EnumMember]
            SP = 154,
            [EnumMember]
            SN = 155,
            [EnumMember]
            RS = 156,
            [EnumMember]
            SC = 157,
            [EnumMember]
            SL = 158,
            [EnumMember]
            SG = 159,
            [EnumMember]
            SK = 160,
            [EnumMember]
            SI = 161,
            [EnumMember]
            SB = 162,
            [EnumMember]
            SO = 163,
            [EnumMember]
            ZA = 164,
            [EnumMember]
            KR = 165,
            [EnumMember]
            ES = 166,
            [EnumMember]
            LK = 167,
            [EnumMember]
            SD = 168,
            [EnumMember]
            SR = 169,
            [EnumMember]
            SZ = 170,
            [EnumMember]
            SE = 171,
            [EnumMember]
            CH = 172,
            [EnumMember]
            SY = 173,
            [EnumMember]
            TW = 174,
            [EnumMember]
            TJ = 175,
            [EnumMember]
            TZ = 176,
            [EnumMember]
            TH = 177,
            [EnumMember]
            TG = 178,
            [EnumMember]
            TO = 179,
            [EnumMember]
            TT = 180,
            [EnumMember]
            TN = 181,
            [EnumMember]
            TR = 182,
            [EnumMember]
            TV = 183,
            [EnumMember]
            UG = 184,
            [EnumMember]
            UA = 185,
            [EnumMember]
            UY = 186,
            [EnumMember]
            UZ = 187,
            [EnumMember]
            VE = 188,
            [EnumMember]
            VN = 189,
            [EnumMember]
            WF = 190,
            [EnumMember]
            YE = 191,
            [EnumMember]
            ZM = 192,
            [EnumMember]
            ZW = 193
            #endregion
        }

        [DataMember]
        public string firstName { get; set; }
        [DataMember]
        public string secondName { get; set; }
        [DataMember]
        public string dateOfBirth { get; set; }
        [DataMember]
        public string title { get; set; }
        [DataMember]
        public Gender? gender { get; set; }
        [DataMember]
        public Occupation? occupation { get; set; }
        [DataMember]
        public Country? countryOfResidence { get; set; }
        [DataMember]
        public Nationality? nationality { get; set; }
        [DataMember]
        public bool smoker { get; set; }
        [DataMember]
        public Benefit[] benefits;

        public Person()
        {

        }
    }


    [DataContract]
    public class ProductType
    {
        [DataMember]
        public string id { get; set; }
        [DataMember]
        public string name { get; set; }
        [DataMember]
        public string[] specificationIds { get; set; }

        public ProductType()
        {

        }
       // [DataMember]
        public ProductType(string AId, string AName, string[] ASpecificationIds)
        {
            this.id = AId;
            this.name = AName;
            this.specificationIds = ASpecificationIds;
        }
    }

    [DataContract]
    public class Signatory
    {
        [DataMember]
        public string name { get; set; }
        [DataMember]
        public string role { get; set; }

        public Signatory()
        {

        }
    }

    [DataContract]
    public enum UserPrivilege
    {
        [EnumMember]
        addExtraMortality = 0
    }

    [DataContract]
    public class User
    {
        [DataMember]
        public string id { get; set; }
        [DataMember]
        public string name { get; set; }
        [DataMember]
        public string[] roles { get; set; }
        [DataMember]
        public string locale { get; set; }
        [DataMember]
        public UserPrivilege[] privileges { get; set; }

        public User()
        {

        }
    }

}
