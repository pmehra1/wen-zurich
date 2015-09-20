using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DAO
{
  public  class Utility
    {

      public static List<string> checkEmptyField(string value, List<string> messages, string message)
      {
          if (value == null || value == "")
          {
              messages.Add(message);
          }
          return messages;
      }
    }
}
