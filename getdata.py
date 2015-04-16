#!/usr/bin/env python
# -*- coding: utf-8 -*- 
import os, sys

if os.path.exists("./meat.csv"):
    sys.exit(0)
else:
    try:
        from ggplot import meat
        meat.to_csv("./meat.csv", index=False)
        sys.exit(0)
    except Exception, err:
        print >> sys.stderr, "unable to read meat.csv or download it"
        print >> sys.stderr, err
        sys.exit(1)



