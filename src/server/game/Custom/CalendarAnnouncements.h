#ifndef CalendarAnnouncements_h__
#define CalendarAnnouncements_h__

// Copies `world.custom_calendar_event` into the three hotfix tables the client reads to fill its
// calendar.
//
// Call this **before** the DB2 stores load: they read their hotfixes at that moment, and anything
// written afterwards would not be seen until the next startup.
namespace CalendarAnnouncements
{
    void Publish();
}

#endif // CalendarAnnouncements_h__
