svn log -r 89448:106580 https://netoffice.svn.codeplex.com/svn/ > netoffice1.log
svn log -r 74699:89430 https://netoffice.svn.codeplex.com/svn/ > netoffice2.log
svn log -r 72739:74689 https://netoffice.svn.codeplex.com/svn/ > netoffice3.log

svn log -r 89448:106580 --xml https://netoffice.svn.codeplex.com/svn/ > netoffice_log1.xml
svn log -r 74699:89430 --xml https://netoffice.svn.codeplex.com/svn/ > netoffice_log2.xml
svn log -r 72739:74689 --xml https://netoffice.svn.codeplex.com/svn/ > netoffice_log3.xml
