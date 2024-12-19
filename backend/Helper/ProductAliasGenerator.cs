using System;
using System.Text.RegularExpressions;

namespace backend.Helper
{
    public class ProductAliasGenerator
    {
        public static string GenerateAlias(string productName)
        {
            if (string.IsNullOrEmpty(productName))
            {
                return string.Empty;
            }
            string alias = productName.ToLower();
            alias = Regex.Replace(alias, @"[^a-z0-9\s]", "");
            alias = Regex.Replace(alias, @"\s+", "-"); 
            alias = alias.Trim('-');
            if (alias.Length > 100)
            {
                alias = alias.Substring(0, 100);
            }
            return alias;
        }
    }
}
