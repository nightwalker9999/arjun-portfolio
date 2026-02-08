import { defineCollection, z } from 'astro:content';

const tools = defineCollection({
  type: 'content',
  schema: z.object({
    name: z.string(),
    icon: z.string(),
    category: z.string(),
    relatedExperience: z.string(),
  }),
});

export const collections = { tools };