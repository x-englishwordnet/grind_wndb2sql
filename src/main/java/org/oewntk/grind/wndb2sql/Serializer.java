/*
 * Copyright (c) 2021-2021. Bernard Bou.
 */

package org.oewntk.grind.wndb2sql;

import org.oewntk.model.Model;
import org.oewntk.sql.out.SerializeNIDs;
import org.oewntk.wndb.in.Factory;

import java.io.File;
import java.io.IOException;

public class Serializer
{
	private static final String FILE_MODEL = "model.ser";

	public static void main(String[] args) throws IOException
	{
		File outDir = new File(args[2]);
		if (!outDir.isDirectory())
		{
			//noinspection ResultOfMethodCallIgnored
			outDir.mkdirs();
		}

		final Model model = Factory.makeModel(args);
		org.oewntk.model.Serialize.serializeCoreModel(model, new File(outDir, FILE_MODEL));
		SerializeNIDs.serializeNIDs(model, outDir);
	}
}
