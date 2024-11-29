#include <pipewire-0.3/pipewire/pipewire.h>
#include <spa-0.2/spa/support/plugin.h>
int main(int argc, char *argv[])
{
        pw_init(&argc, &argv);
 
        fprintf(stdout, "Compiled with libpipewire %s\n"
                        "Linked with libpipewire %s\n",
                                pw_get_headers_version(),
                                pw_get_library_version());
        return 0;
}
