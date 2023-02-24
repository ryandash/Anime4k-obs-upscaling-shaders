@ECHO off

set "input=%~1"
setlocal EnableDelayedExpansion
set "filename="
set num=1
set passnum=1
set "first="
set "second="
set passrepeat=0
set temppassnum=1

cd /d %~dp0

for /f "tokens=* delims=" %%i in ('type "!input!" ^| find /v /n ""') do (
	set a=%%i
	set a=!a:*]=]!
	set line=!a:~1!
	set "whitespace=!line: =!"
	set "bindconv2d=!whitespace:BINDconv2d=!"
	set "def=!whitespace:define=!"

	if not "!whitespace!"=="!bindconv2d!" (
		set "filename=!input:.glsl=!!num!.effect"
		if "!first!"=="" (
			for /f "tokens=* delims=" %%j in ('type "first.effect" ^| find /v /n ""') do (
				set b=%%j
				set b=!b:*]=]!
				if not "!b:~1!"=="" (
					echo !b:~1!>> !filename!
				) else (
					echo:>> !filename!
				)
			)
			echo:>> !filename!
			set "first=not"
		)
		echo uniform texture2d _PreviousPass!passnum!^<>> !filename!
		echo     string name = ^"Previous Pass!passnum!^";>> !filename!
		echo     string field_type = ^"input^";>> !filename!
		echo ^>;>> !filename!
		echo:>> !filename!
		set /A passnum=!passnum!+1
		set "filename="
	)

	if not "!whitespace!"=="!def!" (
		set "filename=!input:.glsl=!!num!.effect"
		if "!first!"=="" (
			for /f "tokens=* delims=" %%j in ('type "first.effect" ^| find /v /n ""') do (
				set b=%%j
				set b=!b:*]=]!
				if not "!b:~1!"=="" (
					echo !b:~1!>> !filename!
				) else (
					echo:>> !filename!
				)
			)
			echo:>> !filename!
			set "first=not"
		)
		if "!second!"=="" (
			for /f "tokens=* delims=" %%j in ('type "second.effect" ^| find /v /n ""') do (
				set c=%%j
				set c=!c:*]=]!
				if not "!c:~1!"=="" (
					echo !c:~1!>> !filename!
				) else (
					echo:>> !filename!
				)
			)
			set "second=not"
		)
		set "string=!line:*_=!"
		set /a number=!string:~0,1!
		call set "start=%%line:!string!=%%"
		set "filter=!start:#define =!
		set "filter=!filter: =!"
		set "search=!filter!!number!("
		set "replace=!filter!!number!(pos, "
		call set "line=%%line:!search!=!replace!%%"
		for /F "tokens=1,2,3,4,5,6,7,8* delims=(" %%a in ("!line!") do (
			set /a currentpass=!passrepeat! %% 2
			set /a passrepeat=!passrepeat!+1
			set /a currentpass=!temppassnum! + !currentpass!
			if "!passrepeat!"=="4" (
				set /a temppassnum=!temppassnum!+2
				set /a passrepeat=0
			)
			set "temp=%%a"
			set "temp2=%%b"
			set "passText=_PreviousPass!currentpass!.Sample(def_sampler, pos"
			if not "!temp2!"=="!temp2:tex=!" (
				echo !temp2! on token 2
			)
			set "temp3=%%c"
			if not "!temp3!"=="!temp3:tex=!" (
				set "line=%%a(%%bparens(!passText! + float2(%%e"
			)
			
			set "string=!temp:*g_=!"
			set /a number=!string:~0,2!	
			set "search=g_!number!"
			set "replace=g_!number!(pos)"		
			
			set "temp4=%%d"
			if not "!temp4!"=="!temp4:tex=!" (
				if not "!line!"=="!line:g_=!" (	
					set "line=%%aparens(%%b(%%c(!passText!)), 0.0))"
					call set "line=%%line:!search!=!replace!%%
				) else (
					set "line=%%a(%%bparens(%%c((!passText! + float2(%%f"
				)
			)
			set "temp5=%%e"
			if not "!temp5!"=="!temp5:tex=!" (
				if not "!line!"=="!line:g_=!" (
					set "line=%%aparens(%%b((!passText!)), 0.0))"
					call set "line=%%line:!search!=!replace!%%	
				) else (
					set "line=%%a(%%bparens(%%c(%%d(!passText! + float2(%%g"
				)
			)
		)
		echo !line!>> !filename!
		set "filename="
	)
	
	if not "!filename!"=="" (
		if not "!line!"=="" (
			set "line=!line:ivec=int!"
			set "line=!line:vec=float!"
			set "line=!line:fract=frac!"
			
			set "string=!line:*go_=!"
			set /a number=!string:~0,1!	
			set "search=go_!number!("
			set "replace=go_!number!(vtx.uv, "
			call set "line=%%line:!search!=!replace!%%
			
			set "string=!line:*g_=!"
			if "!string:~1,2!"==";" (
				set /a number=!string:~0,1!
			) else (
				set /a number=!string:~0,2!
			)			
			set "search=g_!number!"
			set "replace=g_!number!(vtx.uv))"
			call set "line=%%line:!search!=!replace!%%

			set "search=MAIN_tex(MAIN_pos)"
			set "replace=_Main.Sample(def_sampler, vtx.uv)"	
			call set "line=%%line:!search!=!replace!%%

			set "line=!line:mat4=mul(float4x4!"
			set "line=!line: *=,!"
			set "line=!line:0);=0));!"

			echo !line!>> !filename!
		) else (
			echo:>> !filename!
		)
	)

	if "!line!"=="vec4 hook() {" (
		if "!first!"=="" (
			for /f "tokens=* delims=" %%j in ('type "first.effect" ^| find /v /n ""') do (
				set b=%%j
				set b=!b:*]=]!
				if not "!b:~1!"=="" (
					echo !b:~1!>> !filename!
				) else (
					echo:>> !filename!
				)
			)
			set "first=not"
		)

		if "!second!"=="" (
			for /f "tokens=* delims=" %%j in ('type "second.effect" ^| find /v /n ""') do (
				set c=%%j
				set c=!c:*]=]!
				if not "!c:~1!"=="" (
					echo !c:~1!>> !filename!
				) else (
					echo:>> !filename!
				)
			)
			set "second=not"
		)
		set /A passnum=!passnum!-1
		set "filename=!input:.glsl=!!num!.effect"

		set "hookInfo=float4 PSDefault(VertFragData vtx, texture2d _Main"
		FOR /L %%a IN (1, 1, !passnum!) DO (
			set "hookInfo=!hookInfo!, texture2d _PreviousPass%%a"
		)

		echo:>> !filename!
		echo !hookInfo!^) : TARGET {>> !filename!
	)

	if "!line!"=="}" (
		echo:>> !filename!
		echo technique Draw>> !filename!
		echo {>> !filename!
		echo     pass>> !filename!
		echo     {>> !filename!
		echo         vertex_shader = VSDefault^(vtx^);>> !filename!
		set "pixelInfo=        pixel_shader = PSDefault(vtx, _Main"
		FOR /L %%a IN (1, 1, !passnum!-1) DO (
			set "pixelInfo=!pixelInfo!, _PreviousPass%%a"
		)
		echo !pixelInfo!^);>> !filename!
		echo     }>> !filename!
		echo }>> !filename!
		set "filename="
		set "first="
		set "second="
		set /a passnum=1
		set /a num=!num!+1
		set /a temppassnum=1
		set /a passrepeat=0
	)
)
pause