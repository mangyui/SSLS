using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using SSLS.WebUI.Models;

namespace SSLS.WebUI.HtmlHelpers
{
    public static class PagingHelpers
    {
        public static MvcHtmlString PageLinks(
            this HtmlHelper html,
            PagingInfo PagingInfo,
            Func<int, string> pageUrl)
        {
            StringBuilder result = new StringBuilder();
            TagBuilder ul = new TagBuilder("ul");
            ul.AddCssClass("pagination pagination-lg");
            for (int i = 0; i <= PagingInfo.TotalPages + 1; i++)
            {
                TagBuilder li = new TagBuilder("li");
                TagBuilder tag = new TagBuilder("a");
                if (i == 0)
                {
                    int n = PagingInfo.CurrentPage - 1;
                    if (PagingInfo.CurrentPage == 1)
                        n = PagingInfo.CurrentPage;
                    tag.MergeAttribute("href", pageUrl(n));
                    tag.InnerHtml = "&laquo;";
                }
                else if (i == PagingInfo.TotalPages + 1)
                {
                    int n = PagingInfo.CurrentPage + 1;
                    if (PagingInfo.CurrentPage == PagingInfo.TotalPages)
                        n = PagingInfo.CurrentPage;
                    tag.MergeAttribute("href", pageUrl(n));
                    tag.InnerHtml = "&raquo;";
                }
                else
                {
                    tag.MergeAttribute("href", pageUrl(i));
                    tag.InnerHtml = i.ToString();
                    if (i == PagingInfo.CurrentPage)
                    {
                        li.AddCssClass("active");
                    }
                }
                li.InnerHtml = tag.ToString();
                result.Append(li.ToString());
            }
            ul.InnerHtml = result.ToString();
            return MvcHtmlString.Create(ul.ToString());
        }
    }
}