.intel_syntax noprefix

#define GLX_X_RENDERABLE               0x8012
#define GLX_DRAWABLE_TYPE              0x8010
#define GLX_RENDER_TYPE                0x8011
#define GLX_X_VISUAL_TYPE              0x22
#define GLX_WINDOW_BIT                 0x00000001
#define GLX_RGBA_BIT                   0x00000001
#define GLX_TRUE_COLOR                 0x8002
#define GLX_RED_SIZE                   8
#define GLX_GREEN_SIZE                 9
#define GLX_BLUE_SIZE                  10
#define GLX_ALPHA_SIZE                 11
#define GLX_DEPTH_SIZE                 12
#define GLX_DOUBLEBUFFER               5

#define GLX_CONTEXT_MAJOR_VERSION_ARB  0x2091
#define GLX_CONTEXT_MINOR_VERSION_ARB  0x2092
#define GLX_CONTEXT_PROFILE_MASK_ARB   0x9126
#define GLX_CONTEXT_CORE_PROFILE_BIT_ARB 0x00000001

#define CWBorderPixel       0x0008
#define CWEventMask         0x0800
#define CWColormap          0x2000
#define KeyPressMask        0x00000001
#define ExposureMask        0x00008000
#define StructureNotifyMask 0x00020000
#define KeyPress            2
#define Expose              12
#define ConfigureNotify     22
#define ClientMessage       33
#define XK_Escape           0xFF1B
#define POLLIN              0x0001

#define GL_COLOR_BUFFER_BIT 0x4000
#define GL_TRIANGLES        4
#define GL_FLOAT            0x1406
#define GL_ARRAY_BUFFER     0x8892
#define GL_STATIC_DRAW      0x88E4
#define GL_FRAGMENT_SHADER  0x8B30
#define GL_VERTEX_SHADER    0x8B31

.section .data
width:  .long 380
height: .long 380

bg_rgba:
    .float 0.1, 0.1, 0.15, 1.0

// 3 vertices: (x, y, z, r, g, b) = 24 bytes/vertex, 72 bytes total
vertices:
    .float -0.6, -0.6, 0.0,   1.0, 0.0, 0.0
    .float  0.6, -0.6, 0.0,   0.0, 1.0, 0.0
    .float  0.0,  0.6, 0.0,   0.0, 0.4, 1.0

fb_attribs:
    .long GLX_X_RENDERABLE,  1
    .long GLX_DRAWABLE_TYPE, GLX_WINDOW_BIT
    .long GLX_RENDER_TYPE,   GLX_RGBA_BIT
    .long GLX_X_VISUAL_TYPE, GLX_TRUE_COLOR
    .long GLX_RED_SIZE,      8
    .long GLX_GREEN_SIZE,    8
    .long GLX_BLUE_SIZE,     8
    .long GLX_ALPHA_SIZE,    8
    .long GLX_DEPTH_SIZE,    24
    .long GLX_DOUBLEBUFFER,  1
    .long 0                 // None

ctx_attribs:
    .long GLX_CONTEXT_MAJOR_VERSION_ARB, 3
    .long GLX_CONTEXT_MINOR_VERSION_ARB, 3
    .long GLX_CONTEXT_PROFILE_MASK_ARB,  GLX_CONTEXT_CORE_PROFILE_BIT_ARB
    .long 0                 // None

vs_src:
    .asciz "#version 330 core\nlayout(location=0) in vec3 p;\nlayout(location=1) in vec3 c;\nout vec3 vc;\nvoid main(){ gl_Position=vec4(p,1.0); vc=c; }\n"
fs_src:
    .asciz "#version 330 core\nin vec3 vc;\nout vec4 fc;\nvoid main(){ fc=vec4(vc,1.0); }\n"

.balign 8
vs_ptr: .quad vs_src
fs_ptr: .quad fs_src

WindowTitle: .asciz "OpenGL 3.3 Core Triangle (GAS)"
wm_del_name: .asciz "WM_DELETE_WINDOW"

s_glXCreateContextAttribsARB: .asciz "glXCreateContextAttribsARB"
s_glGenVertexArrays:          .asciz "glGenVertexArrays"
s_glBindVertexArray:          .asciz "glBindVertexArray"
s_glGenBuffers:               .asciz "glGenBuffers"
s_glBindBuffer:               .asciz "glBindBuffer"
s_glBufferData:               .asciz "glBufferData"
s_glCreateShader:             .asciz "glCreateShader"
s_glShaderSource:             .asciz "glShaderSource"
s_glCompileShader:            .asciz "glCompileShader"
s_glCreateProgram:            .asciz "glCreateProgram"
s_glAttachShader:             .asciz "glAttachShader"
s_glLinkProgram:              .asciz "glLinkProgram"
s_glUseProgram:               .asciz "glUseProgram"
s_glVertexAttribPointer:      .asciz "glVertexAttribPointer"
s_glEnableVertexAttribArray:  .asciz "glEnableVertexAttribArray"

.balign 8
gl_table:
    .quad s_glGenVertexArrays,         p_glGenVertexArrays
    .quad s_glBindVertexArray,         p_glBindVertexArray
    .quad s_glGenBuffers,              p_glGenBuffers
    .quad s_glBindBuffer,              p_glBindBuffer
    .quad s_glBufferData,              p_glBufferData
    .quad s_glCreateShader,            p_glCreateShader
    .quad s_glShaderSource,            p_glShaderSource
    .quad s_glCompileShader,           p_glCompileShader
    .quad s_glCreateProgram,           p_glCreateProgram
    .quad s_glAttachShader,            p_glAttachShader
    .quad s_glLinkProgram,             p_glLinkProgram
    .quad s_glUseProgram,              p_glUseProgram
    .quad s_glVertexAttribPointer,     p_glVertexAttribPointer
    .quad s_glEnableVertexAttribArray, p_glEnableVertexAttribArray
    .quad 0, 0

.section .bss
.balign 8
hDisplay:  .skip 8
hWindow:   .skip 8
hContext:  .skip 8
fb_config: .skip 8
wm_delete: .skip 8
pfd:       .skip 8          // struct pollfd { int fd; short events; short revents; }
swa:       .skip 112        // XSetWindowAttributes (112 bytes on x86_64)
xev:       .skip 192        // XEvent (192 bytes on x86_64)
nelements: .skip 4
vao:       .skip 4
vbo:       .skip 4

.balign 8
p_glXCreateContextAttribsARB: .skip 8
p_glGenVertexArrays:          .skip 8
p_glBindVertexArray:          .skip 8
p_glGenBuffers:               .skip 8
p_glBindBuffer:               .skip 8
p_glBufferData:               .skip 8
p_glCreateShader:             .skip 8
p_glShaderSource:             .skip 8
p_glCompileShader:            .skip 8
p_glCreateProgram:            .skip 8
p_glAttachShader:             .skip 8
p_glLinkProgram:              .skip 8
p_glUseProgram:               .skip 8
p_glVertexAttribPointer:      .skip 8
p_glEnableVertexAttribArray:  .skip 8

.section .text
.globl main

main:
    push rbx
    push r12
    push r13
    push r14
    sub rsp, 56             // 48B stack args for XCreateWindow + 8B alignment

    xor edi, edi
    call XOpenDisplay@PLT
    test rax, rax
    jz .Lfail
    mov r14, rax            // r14 = Display*
    mov qword ptr [rip + hDisplay], rax

    mov rdi, r14
    call XConnectionNumber@PLT
    mov dword ptr [rip + pfd], eax
    mov word ptr [rip + pfd + 4], POLLIN

    mov rdi, r14
    call XDefaultScreen@PLT

    mov rdi, r14
    mov esi, eax
    lea rdx, [rip + fb_attribs]
    lea rcx, [rip + nelements]
    call glXChooseFBConfig@PLT
    test rax, rax
    jz .Lfail
    cmp dword ptr [rip + nelements], 0
    jle .Lfail
    mov rbx, qword ptr [rax]        // configs[0]
    mov qword ptr [rip + fb_config], rbx

    mov rdi, rax
    call XFree@PLT

    mov rdi, r14
    mov rsi, qword ptr [rip + fb_config]
    call glXGetVisualFromFBConfig@PLT
    test rax, rax
    jz .Lfail
    mov r12, rax            // r12 = XVisualInfo*

    mov rdi, r14
    mov esi, dword ptr [r12 + 16]   // vi->screen
    call XRootWindow@PLT
    mov r13, rax            // r13 = root Window

    mov rdi, r14
    mov rsi, r13
    mov rdx, qword ptr [r12]        // vi->visual
    xor ecx, ecx                    // AllocNone
    call XCreateColormap@PLT
    mov qword ptr [rip + swa + 96], rax                 // swa.colormap
    mov qword ptr [rip + swa + 72], (KeyPressMask | ExposureMask | StructureNotifyMask)

    mov rdi, r14
    mov rsi, r13
    mov edx, 100
    mov ecx, 100
    mov r8d, dword ptr [rip + width]
    mov r9d, dword ptr [rip + height]
    mov qword ptr [rsp + 0], 0                          // border_width
    mov eax, dword ptr [r12 + 20]                       // vi->depth
    mov qword ptr [rsp + 8], rax
    mov qword ptr [rsp + 16], 1                         // InputOutput
    mov rax, qword ptr [r12]                            // vi->visual
    mov qword ptr [rsp + 24], rax
    mov qword ptr [rsp + 32], (CWBorderPixel | CWEventMask | CWColormap)
    lea rax, [rip + swa]
    mov qword ptr [rsp + 40], rax
    call XCreateWindow@PLT
    mov qword ptr [rip + hWindow], rax

    mov rdi, r12
    call XFree@PLT

    mov rdi, r14
    mov rsi, qword ptr [rip + hWindow]
    lea rdx, [rip + WindowTitle]
    call XStoreName@PLT

    mov rdi, r14
    lea rsi, [rip + wm_del_name]
    xor edx, edx
    call XInternAtom@PLT
    mov qword ptr [rip + wm_delete], rax

    mov rdi, r14
    mov rsi, qword ptr [rip + hWindow]
    lea rdx, [rip + wm_delete]
    mov ecx, 1
    call XSetWMProtocols@PLT

    mov rdi, r14
    mov rsi, qword ptr [rip + hWindow]
    call XMapWindow@PLT

    // Create OpenGL 3.3 Core context
    lea rdi, [rip + s_glXCreateContextAttribsARB]
    call glXGetProcAddressARB@PLT
    test rax, rax
    jz .Lfail
    mov qword ptr [rip + p_glXCreateContextAttribsARB], rax

    mov rdi, r14
    mov rsi, qword ptr [rip + fb_config]
    xor edx, edx                    // share_context = NULL
    mov ecx, 1                      // direct = True
    lea r8, [rip + ctx_attribs]
    call qword ptr [rip + p_glXCreateContextAttribsARB]
    test rax, rax
    jz .Lfail
    mov qword ptr [rip + hContext], rax

    mov rdi, r14
    mov rsi, qword ptr [rip + hWindow]
    mov rdx, rax
    call glXMakeCurrent@PLT

    // Load all GL 3.3 function pointers
    lea rbx, [rip + gl_table]
.Lload_gl:
    mov rdi, qword ptr [rbx]
    test rdi, rdi
    jz .Lload_done
    call glXGetProcAddressARB@PLT
    mov rdx, qword ptr [rbx + 8]
    mov qword ptr [rdx], rax
    add rbx, 16
    jmp .Lload_gl
.Lload_done:

    // Compile vertex + fragment shaders and link program
    mov edi, GL_VERTEX_SHADER
    call qword ptr [rip + p_glCreateShader]
    mov r12d, eax
    mov edi, r12d
    mov esi, 1
    lea rdx, [rip + vs_ptr]
    xor ecx, ecx
    call qword ptr [rip + p_glShaderSource]
    mov edi, r12d
    call qword ptr [rip + p_glCompileShader]

    mov edi, GL_FRAGMENT_SHADER
    call qword ptr [rip + p_glCreateShader]
    mov r13d, eax
    mov edi, r13d
    mov esi, 1
    lea rdx, [rip + fs_ptr]
    xor ecx, ecx
    call qword ptr [rip + p_glShaderSource]
    mov edi, r13d
    call qword ptr [rip + p_glCompileShader]

    call qword ptr [rip + p_glCreateProgram]
    mov ebx, eax
    mov edi, ebx
    mov esi, r12d
    call qword ptr [rip + p_glAttachShader]
    mov edi, ebx
    mov esi, r13d
    call qword ptr [rip + p_glAttachShader]
    mov edi, ebx
    call qword ptr [rip + p_glLinkProgram]
    mov edi, ebx
    call qword ptr [rip + p_glUseProgram]

    // Setup VAO + VBO
    mov edi, 1
    lea rsi, [rip + vao]
    call qword ptr [rip + p_glGenVertexArrays]
    mov edi, dword ptr [rip + vao]
    call qword ptr [rip + p_glBindVertexArray]

    mov edi, 1
    lea rsi, [rip + vbo]
    call qword ptr [rip + p_glGenBuffers]
    mov edi, GL_ARRAY_BUFFER
    mov esi, dword ptr [rip + vbo]
    call qword ptr [rip + p_glBindBuffer]

    mov edi, GL_ARRAY_BUFFER
    mov esi, 72
    lea rdx, [rip + vertices]
    mov ecx, GL_STATIC_DRAW
    call qword ptr [rip + p_glBufferData]

    // Attribute 0: position (3 floats, stride 24, offset 0)
    xor edi, edi
    mov esi, 3
    mov edx, GL_FLOAT
    xor ecx, ecx
    mov r8d, 24
    xor r9d, r9d
    call qword ptr [rip + p_glVertexAttribPointer]
    xor edi, edi
    call qword ptr [rip + p_glEnableVertexAttribArray]

    // Attribute 1: color (3 floats, stride 24, offset 12)
    mov edi, 1
    mov esi, 3
    mov edx, GL_FLOAT
    xor ecx, ecx
    mov r8d, 24
    mov r9d, 12
    call qword ptr [rip + p_glVertexAttribPointer]
    mov edi, 1
    call qword ptr [rip + p_glEnableVertexAttribArray]

    xor edi, edi
    xor esi, esi
    mov edx, dword ptr [rip + width]
    mov ecx, dword ptr [rip + height]
    call glViewport@PLT

    jmp .Ldraw

.Levent_loop:
    mov rdi, r14
    call XPending@PLT
    test eax, eax
    jz .Lwait_frame

    mov rdi, r14
    lea rsi, [rip + xev]
    call XNextEvent@PLT

    mov eax, dword ptr [rip + xev]
    cmp eax, KeyPress
    je .Lon_keypress
    cmp eax, ClientMessage
    je .Lon_clientmsg
    cmp eax, ConfigureNotify
    je .Lon_resize
    jmp .Levent_loop

.Lon_keypress:
    lea rdi, [rip + xev]
    xor esi, esi
    call XLookupKeysym@PLT
    cmp eax, XK_Escape
    je .Lexit
    jmp .Levent_loop

.Lon_clientmsg:
    mov rax, qword ptr [rip + wm_delete]
    cmp qword ptr [rip + xev + 56], rax
    je .Lexit
    jmp .Levent_loop

.Lon_resize:
    mov edx, dword ptr [rip + xev + 56]     // xconfigure.width
    mov ecx, dword ptr [rip + xev + 60]     // xconfigure.height
    test ecx, ecx
    jnz .Lsize_ok
    mov ecx, 1
.Lsize_ok:
    mov dword ptr [rip + width], edx
    mov dword ptr [rip + height], ecx
    xor edi, edi
    xor esi, esi
    call glViewport@PLT
    jmp .Levent_loop

.Lwait_frame:
    lea rdi, [rip + pfd]
    mov esi, 1
    mov edx, 16             // sleep up to 16 ms (~60 Hz) waiting for X11 events
    call poll@PLT

.Ldraw:
    movss xmm0, dword ptr [rip + bg_rgba]
    movss xmm1, dword ptr [rip + bg_rgba + 4]
    movss xmm2, dword ptr [rip + bg_rgba + 8]
    movss xmm3, dword ptr [rip + bg_rgba + 12]
    call glClearColor@PLT

    mov edi, GL_COLOR_BUFFER_BIT
    call glClear@PLT

    mov edi, GL_TRIANGLES
    xor esi, esi
    mov edx, 3
    call glDrawArrays@PLT

    mov rdi, r14
    mov rsi, qword ptr [rip + hWindow]
    call glXSwapBuffers@PLT
    jmp .Levent_loop

.Lexit:
    xor eax, eax
    jmp .Ldone

.Lfail:
    mov eax, 1

.Ldone:
    add rsp, 56
    pop r14
    pop r13
    pop r12
    pop rbx
    ret

.section .note.GNU-stack,"",@progbits
