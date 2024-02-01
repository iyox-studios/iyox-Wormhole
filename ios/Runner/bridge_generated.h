#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
typedef struct _Dart_Handle* Dart_Handle;

typedef struct DartCObject DartCObject;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct wire_StringList {
  struct wire_uint_8_list **ptr;
  int32_t len;
} wire_StringList;

typedef struct wire_ServerConfig {
  struct wire_uint_8_list *rendezvous_url;
  struct wire_uint_8_list *transit_url;
} wire_ServerConfig;

typedef struct DartCObject *WireSyncReturn;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

Dart_Handle get_dart_object(uintptr_t ptr);

void drop_dart_object(uintptr_t ptr);

uintptr_t new_dart_opaque(Dart_Handle handle);

intptr_t init_frb_dart_api_dl(void *obj);

void wire_init(int64_t port_, struct wire_uint_8_list *temp_file_path);

void wire_send_files(int64_t port_,
                     struct wire_StringList *file_paths,
                     struct wire_uint_8_list *name,
                     uint8_t code_length,
                     struct wire_ServerConfig *server_config);

void wire_send_folder(int64_t port_,
                      struct wire_uint_8_list *folder_path,
                      struct wire_uint_8_list *name,
                      uint8_t code_length,
                      struct wire_ServerConfig *server_config);

void wire_request_file(int64_t port_,
                       struct wire_uint_8_list *passphrase,
                       struct wire_uint_8_list *storage_folder,
                       struct wire_ServerConfig *server_config);

void wire_get_passphrase_uri(int64_t port_,
                             struct wire_uint_8_list *passphrase,
                             struct wire_uint_8_list *rendezvous_server);

void wire_get_build_time(int64_t port_);

void wire_default_rendezvous_url(int64_t port_);

void wire_default_transit_url(int64_t port_);

struct wire_StringList *new_StringList_0(int32_t len);

struct wire_ServerConfig *new_box_autoadd_server_config_0(void);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturn(WireSyncReturn ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_init);
    dummy_var ^= ((int64_t) (void*) wire_send_files);
    dummy_var ^= ((int64_t) (void*) wire_send_folder);
    dummy_var ^= ((int64_t) (void*) wire_request_file);
    dummy_var ^= ((int64_t) (void*) wire_get_passphrase_uri);
    dummy_var ^= ((int64_t) (void*) wire_get_build_time);
    dummy_var ^= ((int64_t) (void*) wire_default_rendezvous_url);
    dummy_var ^= ((int64_t) (void*) wire_default_transit_url);
    dummy_var ^= ((int64_t) (void*) new_StringList_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_server_config_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}
